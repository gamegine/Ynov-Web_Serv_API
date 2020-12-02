class CreateWatches < ActiveRecord::Migration[6.0]
  def change
    create_table :watches do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :movie, null: false, foreign_key: true
      t.integer :rating
      t.string :comment

      t.timestamps
    end
  end
end
