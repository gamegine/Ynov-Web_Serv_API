require 'test_helper'

class MoviesControllerTest < ActionDispatch::IntegrationTest

  # Pundit
  setup do
    get '/users/sign_in' 
    sign_in users(:one)
    post user_session_url

    # If you want to test that things are working correctly, uncomment this below:
    follow_redirect!
    assert_response :success
    @movie = movies(:one)
  end

  test "should get index" do
    EXPECTED = Movie.all.map { |e| movie_to_json e }

    get movies_url('json')
    assert_response :success
    # json_response = JSON.parse(response.body)
    json_response = ActiveSupport::JSON.decode @response.body
    assert_equal json_response, EXPECTED
  end

  test "should get new" do
    get new_movie_url
    assert_response :success
  end

  test "should create movie" do
    assert_difference('Movie.count', 1) do
      post movies_url, params: { movie: { title: "@movie.title" } }
    end

    assert_redirected_to movie_url(Movie.last)
    assert_equal Movie.last.title, "@movie.title"
  end

  test "should show movie" do
    EXPECTED = movie_to_json @movie

    get movie_url({:id=>@movie.id, format: :json})
    assert_response :success
    # json_response = JSON.parse(response.body)
    json_response = ActiveSupport::JSON.decode @response.body
    assert_equal json_response, EXPECTED
  end

  test "should get edit" do
    get edit_movie_url(@movie)
    assert_response :success
  end

  test "should update movie" do
    movie = Movie.create({
        title: "Movie Title",
        user: users(:one)
    })

    assert_changes "Movie.last.title", from: "Movie Title", to: "test" do
      patch movie_url(movie), params: { movie: { title: "test" } }
    end

    assert_redirected_to movie_url(movie)
  end

  test "should destroy movie" do
    movie = Movie.create({
        title: "Movie Title",
        user: users(:one)
    })
    assert_difference('Movie.count', -1) do
      delete movie_url(movie)
    end

    assert_redirected_to movies_url
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
