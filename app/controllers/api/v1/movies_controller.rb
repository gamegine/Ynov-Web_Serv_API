class Api::V1::MoviesController < Api::V1::BaseController
  before_action :set_movie, only: [:show, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:index, :show]

  # GET /movies
  def index
    @movie = policy_scope(Movie)
    @movies = Movie.all
  end

  # GET /movies/1
  def show
    authorize @movie
  end

  # POST /movies
  def create
    @movie = Movie.new(movie_params)
    @movie.user = current_user
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
end
