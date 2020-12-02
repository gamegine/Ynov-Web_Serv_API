require 'test_helper'

class Api::V1::SearchesControllerTest < ActionDispatch::IntegrationTest

  test "should search title" do
    expected = [movies(:one)].map { |e| movie_to_json e }
    
    get api_v1_search_title_url, params: {title: "tes"}
    assert_response :success
    json_response = ActiveSupport::JSON.decode @response.body
    assert_equal json_response, expected
  end


  test "should search titles" do
    expected = [movies(:one),movies(:two)].map { |e| movie_to_json e }
    
    get api_v1_search_title_url, params: {title: "tes,cou"}
    assert_response :success
    json_response = ActiveSupport::JSON.decode @response.body
    assert_equal json_response, expected
  end

  test "should search titles empty" do
    expected = {"message"=>"put a title"}
    
    get api_v1_search_title_url, params: {title: ""}
    assert_response :success
    json_response = ActiveSupport::JSON.decode @response.body
    assert_equal expected,json_response
  end

  # test "should search titles not found" do
  #   expected = {"message"=>"movies not found"}
    
  #   get api_v1_search_title_url, params: {title: "ererrerrrererer"}
  #   assert_response :success
  #   json_response = ActiveSupport::JSON.decode @response.body
  #   assert_equal expected,json_response
  # end

  test "should search date" do
    expected = [movies(:one)].map { |e| movie_to_json e }
    
    get api_v1_search_date_url, params: {date: "2020-11-15"}
    assert_response :success
    json_response = ActiveSupport::JSON.decode @response.body
    assert_equal json_response, expected
  end

  test "should search few dates" do
    expected = [movies(:one),movies(:two)].map { |e| movie_to_json e }
    
    get api_v1_search_date_url, params: {date: "2020-11-15,2020-11-20"}
    assert_response :success
    json_response = ActiveSupport::JSON.decode @response.body
    assert_equal json_response, expected
  end

  test "should search datesBetween" do
    expected = [movies(:one),movies(:two),movies(:three)].map { |e| movie_to_json e }

    get api_v1_search_date_url, params: {date: "[2020-11-15,2020-11-20]"}
    assert_response :success
    json_response = ActiveSupport::JSON.decode @response.body
    assert_equal json_response, expected
  end

  test "should search datesInferior" do
    expected = [movies(:one),movies(:two),movies(:three)].map { |e| movie_to_json e }

    get api_v1_search_date_url, params: {date: "[,2020-11-20]"}
    assert_response :success
    json_response = ActiveSupport::JSON.decode @response.body
    assert_equal json_response, expected
  end

  test "should search datesSuperior" do
    expected = [movies(:two)].map { |e| movie_to_json e }
  
    get api_v1_search_date_url, params: {date: "[2020-11-20,]"}
    assert_response :success
    json_response = ActiveSupport::JSON.decode @response.body
    assert_equal expected,json_response
  end

  test "should search rating" do
    expected = [watches(:one)].map { |e| watch_to_json e }
    
    get api_v1_search_rating_url, params: {rating: "1"}
    assert_response :success
    json_response = ActiveSupport::JSON.decode @response.body
    assert_equal json_response, expected
  end

  test "should search ratings" do
    expected = [watches(:one),watches(:two)].map { |e| watch_to_json e }
    
    get api_v1_search_rating_url, params: {rating: "1,2"}
    assert_response :success
    json_response = ActiveSupport::JSON.decode @response.body
    assert_equal json_response, expected
  end

  test "should search Between rating" do
    expected = [watches(:one),watches(:two)].map { |e| watch_to_json e }
    
    get api_v1_search_rating_url, params: {rating: "[1,2]"}
    assert_response :success
    json_response = ActiveSupport::JSON.decode @response.body
    assert_equal json_response, expected
  end

  test "should search Superior rating" do
    expected = [watches(:two)].map { |e| watch_to_json e }
    
    get api_v1_search_rating_url, params: {rating: "[2,]"}
    assert_response :success
    json_response = ActiveSupport::JSON.decode @response.body
    assert_equal json_response, expected
  end

  test "should search Inferior rating" do
    expected = [watches(:one)].map { |e| watch_to_json e }
    
    get api_v1_search_rating_url, params: {rating: "[,1]"}
    assert_response :success
    json_response = ActiveSupport::JSON.decode @response.body
    assert_equal json_response, expected
  end


  

  private

  def movie_to_json (model)
    res = model.as_json(except: [:user_id])
    res['url'] = movie_url({:id=>res['id'], format: :json})
    return res
  end

  def watch_to_json (model)
    res = model.as_json()
    res['url'] = api_v1_watch_url({:id=>res['id']})
    return res
  end
end
