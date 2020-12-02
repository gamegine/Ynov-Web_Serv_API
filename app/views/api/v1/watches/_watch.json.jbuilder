json.extract! watch, :id, :user_id, :movie_id, :rating, :comment, :created_at, :updated_at
json.url api_v1_watch_url(watch, format: :json)
