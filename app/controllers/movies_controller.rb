class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:index, :show]
  # GET /movies
  # GET /movies.json
  def index
    @movie = policy_scope(Movie)
    @movies = Movie.all
  end

  # GET /movies/1
  # GET /movies/1.json
  def show
    authorize @movie
  end

  # GET /movies/new
  def new
    @movie = Movie.new
    authorize @movie
  end

  # GET /movies/1/edit
  def edit
    authorize @movie
  end

  # POST /movies
  # POST /movies.json
  def create
    @movie = Movie.new(movie_params)
    @movie.user = current_user
    authorize @movie
    respond_to do |format|
      if @movie.save
        format.html { redirect_to @movie, notice: 'Movie was successfully created.' }
        format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movies/1
  # PATCH/PUT /movies/1.json
  def update
    authorize @movie
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to @movie, notice: 'Movie was successfully updated.' }
        format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1
  # DELETE /movies/1.json
  def destroy
    @movie.destroy
    authorize @movie
    respond_to do |format|
      format.html { redirect_to movies_url, notice: 'Movie was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def searchTitle
    title = params[:title]
    if title=="" || title==nil then
      return render json: {message: "put a title"}
    end
    titles = title.split(",").map(&:downcase).map{|string|"%"+string+"%"}
    if titles!=[]
      @movie = Movie.all.where("lower(title) ILIKE ANY (array[:title])", title: titles) 
      authorize @movie
      return render json: {data: @movie}
    else
      return render json: {message: "movies not found"}
    end
  end

  def searchDate
    dates = params[:date].split(",").uniq
    movie = []
    dates.each do |d|
      date = Date.parse(d)
      query = Movie.where(:created_at => date.beginning_of_day..date.end_of_day)
      authorize query
      movie+=query
    end
    @movie = movie
    return render json: {data: @movie}
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
