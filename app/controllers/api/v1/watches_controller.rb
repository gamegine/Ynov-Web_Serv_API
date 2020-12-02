class Api::V1::WatchesController < Api::V1::BaseController
  before_action :set_watch, only: [:show, :edit, :update, :destroy]
  #skip_before_action :authenticate_user!, only: [:index, :show]
  skip_before_action :doorkeeper_authorize!, only: [:index ,:show]

  # GET /watches
  def index
    @watches = policy_scope(Watch)
  end

  # GET /watches/1
  def show
    authorize @watch
  end

  # POST /watches
  def create
    @watch = Watch.new(watch_params)
    authorize @watch

    if @watch.save
      render :show, status: :created, location: api_v1_watch_url(@watch)
    else
      render json: @watch.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /watches/1
  def update
    authorize @watch
    if @watch.update(watch_params)
      render :show, status: :ok, location: api_v1_watch_url(@watch)
    else
      render json: @watch.errors, status: :unprocessable_entity
    end
  end

  # DELETE /watches/1
  def destroy
    @watch.destroy
    authorize @watch
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_watch
      @watch = Watch.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def watch_params
      params.require(:watch).permit(:user_id, :movie_id, :rating, :comment)
    end
end
