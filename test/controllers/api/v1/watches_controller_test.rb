require 'test_helper'

class Api::V1::WatchesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @token = Doorkeeper::AccessToken.last
    @watch = watches(:one)
  end

  test "should get index" do
    expected = Watch.all.map { |e| watch_to_json e }

    get api_v1_watches_url
    assert_response :success

    json_response = ActiveSupport::JSON.decode @response.body
    assert_equal json_response, expected
  end

  test "should create watch" do
    assert_difference('Watch.count') do
      post api_v1_watches_url({:access_token => @token.token}), params: { watch: { user_id: users(:one).id, movie_id: movies(:one).id } }
      assert_response :success
    end

    assert_equal Movie.last.user_id, users(:one).id

    json_response = ActiveSupport::JSON.decode @response.body
    expected = watch_to_json Watch.last
    assert_equal expected, json_response
  end

  test "should show watch" do
    expected = watch_to_json @watch

    get api_v1_watch_url(@watch)
    assert_response :success
    json_response = ActiveSupport::JSON.decode @response.body
    assert_equal json_response, expected
  end

  test "should update watch" do
    elm = Watch.create({
      user_id: users(:one).id,
      movie_id: movies(:one).id,
      comment: "MyString"
    })

    assert_changes "Watch.last.comment", from: "MyString", to: "test" do
      patch api_v1_watch_url({:id=>elm.id, :access_token => @token.token}), params: { watch: { comment: "test" } }
      assert_response :success
    end
    json_response = ActiveSupport::JSON.decode @response.body
    expected = watch_to_json Watch.last
    assert_equal expected, json_response
  end

  test "should destroy watch" do
    assert_difference('Watch.count', -1) do
      delete api_v1_watch_url({:id=>@watch.id, :access_token => @token.token})
      assert_response :success
    end
  end

  private
  def watch_to_json (model)
    res = model.as_json()
    res['url'] = api_v1_watch_url({:id=>res['id']})
    return res
  end
end
