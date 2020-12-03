class Api::V1::WatchesController < Api::V1::BaseController
  include Swagger::Blocks
  before_action :set_watch, only: [:show, :edit, :update, :destroy]
  #skip_before_action :authenticate_user!, only: [:index, :show]
  skip_before_action :doorkeeper_authorize!, only: [:index ,:show]



  swagger_path '/watches' do
    operation :get do
      key :summary, 'get all watches'
      key :produces, [
        'application/json',
        'text/html',
      ]
      key :tags, [
        'watch'
      ]
      response 200 do
        key :description, 'get Watch.all'
        schema do
          key :type, :array
          items do
            key :'$ref', :Watch
          end
        end
      end
    end
    operation :post do
      key :summary, 'post watch'
      key :description, 'Creates a new Watch.  Duplicates are allowed'
      key :produces, [
        'application/json'
      ]
      key :tags, [
        'watch'
      ]
      parameter do
        key :name, :user_id
        key :in, :body
        key :description, 'user join to watch'
        key :required, true
        key :type, :integer
      end
      parameter do
        key :name, :movie_id
        key :in, :body
        key :description, 'movie join to watch'
        key :required, true
        key :type, :integer
      end
      parameter do
        key :name, :comment
        key :in, :body
        key :description, 'comment to watch'
        key :required, true
        key :type, :string
      end
      response 200 do
        key :description, 'watch response'
        schema do
          key :'$ref', :Watch
          end
        end
      end
  end

  swagger_path '/watches/{id}' do
    operation :get do
      key :summary, 'Find watch by ID'
      key :description, 'Returns a single watch'
      key :produces, [
        'application/json',
        'text/html',
      ]
      key :tags, [
        'watch'
      ]
      parameter do
        key :name, :id
        key :in, :path
        key :description, 'ID of watch to fetch'
        key :required, true
        key :type, :integer
      end
      response 200 do
        key :description, 'get watch'
        schema do
          key :type, :array
          items do
            key :'$ref', :Movie
          end
        end
      end
    end
    operation :put do
      key :summary, 'put a watch'
      key :description, 'Update a watch'
      key :produces, [
        'application/json',
        'text/html',
      ]
      key :tags, [
        'watch'
      ]
      parameter do
        key :name, :id
        key :in, :path
        key :description, 'ID of watch to update'
        key :required, true
        key :type, :integer
      end
      parameter do
        key :name, :comment
        key :in, :body
        key :description, 'comment of watch to update'
        key :required, true
        schema do
          key :'$ref', :Movie
        end
      end
    end
    operation :delete do
      key :summary, 'delete a watch'
      key :description, 'delete a single watch based on the ID supplied'
      key :produces, [
        'application/json',
        'text/html',
      ]
      key :tags, [
        'watch'
      ]
      parameter do
        key :name, :id
        key :in, :path
        key :description, 'ID of watch to delete'
        key :required, true
        key :type, :integer
      end
      response 204 do
        key :description, ''
      end
    end
  end


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
