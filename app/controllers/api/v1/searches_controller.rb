class Api::V1::SearchesController < Api::V1::BaseController
  include Swagger::Blocks


  swagger_path '/search/title={titles}' do
    operation :get do
      key :summary, 'Find movie by titles'
      key :produces, [
        'application/json',
        'text/html',
      ]
      key :tags, [
        'movie'
      ]
      parameter do
        key :name, :title
        key :in, :path
        key :required, true
        key :type, :string
      end
      response 200 do
        key :description, 'get Movies'
        schema do
          key :type, :array
          items do
            key :'$ref', :Movie
          end
        end
      end
    end
  end

  swagger_path '/search/date={dates}' do
    operation :get do
      key :summary, 'Find movie by dates'
      key :produces, [
        'application/json',
        'text/html',
      ]
      key :tags, [
        'movie'
      ]
      parameter do
        key :name, :date
        key :in, :path
        key :required, true
        key :type, :string
        key :format, :date
      end
      response 200 do
        key :description, 'get Movies'
        schema do
          key :type, :array
          items do
            key :'$ref', :Movie
          end
        end
      end
    end
  end

  swagger_path '/search/date=[date1,date2]' do
    operation :get do
      key :summary, 'Find movie by dates between date1 and date2 inclusive'
      key :produces, [
        'application/json',
        'text/html',
      ]
      key :tags, [
        'movie'
      ]
      parameter do
        key :name, :date
        key :in, :path
        key :required, true
        key :type, :array
      end
      response 200 do
        key :description, 'get Movies'
        schema do
          key :type, :array
          items do
            key :'$ref', :Movie
          end
        end
      end
    end
  end

  swagger_path '/search/date=[date1,]' do
    operation :get do
      key :summary, 'Find movie where dates are superiors to date1 inclusive'
      key :produces, [
        'application/json',
        'text/html',
      ]
      key :tags, [
        'movie'
      ]
      parameter do
        key :name, :date
        key :in, :path
        key :required, true
        key :type, :array
      end
      response 200 do
        key :description, 'get Movies'
        schema do
          key :type, :array
          items do
            key :'$ref', :Movie
          end
        end
      end
    end
  end

  swagger_path '/search/date=[,date1]' do
    operation :get do
      key :summary, 'Find movie where dates are inferiors to date1 inclusive'
      key :produces, [
        'application/json',
        'text/html',
      ]
      key :tags, [
        'movie'
      ]
      parameter do
        key :name, :date
        key :in, :path
        key :required, true
        key :type, :array
      end
      response 200 do
        key :description, 'get Movies'
        schema do
          key :type, :array
          items do
            key :'$ref', :Movie
          end
        end
      end
    end
  end


  skip_before_action :doorkeeper_authorize!

  def searchTitle
    authorize Movie
    title = params[:title]
    # title = params.require(:title)
    if title=="" || title==nil then
        return render json: {message: "put a title"}
    end
    titles = title.split(",").map(&:downcase).map{|string|"%"+string+"%"}
    @movies = Movie.all.where("lower(title) ILIKE ANY (array[:title])", title: titles) 
    test = @movies.length
    if @movies.length==0 || @movies.length==nil
      return render json: {message: "movies not found"}
    else
      authorize @movies
    end
  end

  def searchDate
    authorize Movie
    regexdate = "/^\d{4}-\d{2}-\d{2}/"

    if params[:date].include? "["
      searchdateRange
    else
      dates = params[:date].split(",").uniq
      movie = []
      dates.each do |d|
        date = Date.parse(d)
        query = Movie.where(:created_at => date.beginning_of_day..date.end_of_day)
        authorize query
        movie+=query
      end
      @movies = movie
      # return render json: {data: @movie.as_json(except: [:user_id])}
    end
  end

  def searchdateRange
      dates = params[:date].tr('[]', '').split(',')
      if params[:date] !~ /^\[(?'date'\d{4}-\d{2}-\d{2}){0,1},(\g'date'){0,1}\]$/ ||
          (dates[0] == nil || dates[0] == "" && dates[1] == nil || dates[1] == "")    
          return render json: {message: "invalid argument"}
      end
      
      dates[0] = (dates[0]!=nil && dates[0]!="") ? Date.parse(dates[0]) : ""
      dates[1] = (dates[1]!=nil && dates[1]!="") ? Date.parse(dates[1]) : ""


      if  dates[0]!="" && dates[1]!=""
          if dates[1] < dates[0]
              return render json: {message: "second date inferior than first"}
          end
          @movies = Movie.where({created_at: dates[0].beginning_of_day..dates[1].end_of_day})
      elsif dates[0] == ""
          @movies = Movie.where('created_at <= ?', dates[1].end_of_day)
      elsif dates[1] == ""
          @movies = Movie.where('created_at >= ?', dates[0].beginning_of_day)
      end
      authorize @movies
      # return render json: {data: @movie.as_json(except: [:user_id])}
  end  
end
