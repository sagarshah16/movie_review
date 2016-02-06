class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :Title
      t.string :Description
      t.string :Duration
      t.string :Actor
      t.string :Rating

      t.timestamps null: false
    end
  end
end
