require 'test_helper'

class Api::V1::MoviesControllerTest < ActionDispatch::IntegrationTest
  setup do
    ######################### no token!
    get '/users/sign_in' 
    sign_in users(:one)
    post user_session_url
    # If you want to test that things are working correctly, uncomment this below:
    follow_redirect!
    assert_response :success
    #########################

    @movie = movies(:one)
  end


  test "should get index" do
    expected = Movie.all.map { |e| movie_to_json e }

    get api_v1_movies_url('json')
    assert_response :success
    # json_response = JSON.parse(response.body)
    json_response = ActiveSupport::JSON.decode @response.body
    assert_equal json_response, expected
  end

  test "should create movie" do
    assert_difference('Movie.count', 1) do
      post api_v1_movies_url, params: { movie: { title: "@movie.title" } }
    end
    assert_equal Movie.last.title, "@movie.title"

    json_response = ActiveSupport::JSON.decode @response.body
    expected = movie_to_json Movie.last
    assert_equal expected, json_response
  end

  test "should show movie" do
    expected = movie_to_json @movie

    get api_v1_movie_url({:id=>@movie.id})
    assert_response :success
    json_response = ActiveSupport::JSON.decode @response.body
    assert_equal json_response, expected
  end

  test "should update movie" do
    movie = Movie.create({
        title: "Movie Title",
        user: users(:one)
    })

    assert_changes "Movie.last.title", from: "Movie Title", to: "test" do
      patch api_v1_movie_url(movie), params: { movie: { title: "test" } }
    end
    json_response = ActiveSupport::JSON.decode @response.body
    expected = movie_to_json Movie.last
    assert_equal expected, json_response
  end

  test "should destroy movie" do
    movie = Movie.create({
        title: "Movie Title",
        user: users(:one)
    })
    assert_difference('Movie.count', -1) do
      delete api_v1_movie_url(movie)
    end
  end

  private
    # Movie.all.as_json(except: [:user_id])
    #       .each { |e| e['url'] = movie_url({:id=>e['id'], format: :json}) }
    #       .each { |e| e['url'] = "http://www.example.com/movies/#{e['id']}.json" }

    def movie_to_json (model)
      res = model.as_json(except: [:user_id])
      res['url'] = movie_url({:id=>res['id'], format: :json})
      return res
    end
end
