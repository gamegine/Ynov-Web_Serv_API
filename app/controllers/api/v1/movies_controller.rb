class Api::V1::MoviesController < Api::V1::BaseController
  include Swagger::Blocks
  before_action :set_movie, only: [:show, :update, :destroy]
  #skip_before_action :authenticate_user!, only: [:index, :show]
  skip_before_action :doorkeeper_authorize!, only: [:index ,:show]

  # GET /movies
  swagger_path '/movies' do
    operation :get do
      key :summary, 'get all movies'
      key :produces, [
        'application/json',
        'text/html',
      ]
      key :tags, [
        'movie'
      ]
      response 200 do
        key :description, 'get Movie.all'
        schema do
          key :type, :array
          items do
            key :'$ref', :Movie
          end
        end
      end
    end
    operation :post do
      key :summary, 'post movie'
      key :description, 'Creates a new movie.  Duplicates are allowed'
      key :produces, [
        'application/json'
      ]
      key :tags, [
        'movie'
      ]
      parameter do
        key :name, :title
        key :in, :body
        key :description, 'Movie to add'
        key :required, true
      end
      response 200 do
        key :description, 'movie response'
        schema do
          key :'$ref', :Movie
          end
        end
      end
  end

  swagger_path '/movies/{id}' do
    operation :get do
      key :summary, 'Find movie by ID'
      key :description, 'Returns a single movie'
      key :produces, [
        'application/json',
        'text/html',
      ]
      key :tags, [
        'movie'
      ]
      parameter do
        key :name, :id
        key :in, :path
        key :description, 'ID of movie to fetch'
        key :required, true
        key :type, :integer
        key :format, :int64
      end
      response 200 do
        key :description, 'get Movie'
        schema do
          key :type, :array
          items do
            key :'$ref', :Movie
          end
        end
      end
    end
    operation :put do
      key :summary, 'put a movie'
      key :description, 'Update a movie'
      key :produces, [
        'application/json',
        'text/html',
      ]
      key :tags, [
        'movie'
      ]
      parameter do
        key :name, :id
        key :in, :path
        key :description, 'ID of movie to update'
        key :required, true
        key :type, :integer
        key :format, :int64
      end
      parameter do
        key :title, 'title'
        key :in, :body
        key :description, 'title of Movie to update'
        key :required, true
        schema do
          key :'$ref', :Movie
        end
      end
    end
    operation :delete do
      key :summary, 'delete a movie'
      key :description, 'delete a single movie based on the ID supplied'
      key :produces, [
        'application/json',
        'text/html',
      ]
      key :tags, [
        'movie'
      ]
      parameter do
        key :name, :id
        key :in, :path
        key :description, 'ID of movie to delete'
        key :required, true
        key :type, :integer
        key :format, :int64
      end
      response 204 do
        key :description, ''
      end
    end
  end


  def index
    @movies = policy_scope(Movie)
  end

  # GET /movies/1
  def show
    authorize @movie
  end

  # POST /movies
  def create
    @movie = Movie.new(movie_params)
    @movie.user = current_resource_owner
    authorize @movie
    if @movie.save
      render :show, status: :created, location: @movie
    else
      render json: @movie.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /movies/1
  def update
    authorize @movie
    if @movie.update(movie_params)
      render :show, status: :ok, location: @movie
    else
      render json: @movie.errors, status: :unprocessable_entity
    end
  end

  # DELETE /movies/1
  def destroy
    @movie.destroy
    authorize @movie
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def movie_params
      params.require(:movie).permit(:title)
    end

    def current_resource_owner
      User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
    end
end
