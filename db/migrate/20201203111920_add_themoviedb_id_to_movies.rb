class AddThemoviedbIdToMovies < ActiveRecord::Migration[6.0]
  def change
    add_column :movies, :themoviedb_id, :integer
  end
end
