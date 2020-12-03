json.extract! movie, :id, :title, :created_at, :updated_at, :themoviedb_id
json.url movie_url(movie, format: :json)
