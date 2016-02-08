class ChangeColumnName < ActiveRecord::Migration
  def change
    rename_column :reviews, :movie, :movie_id
  end
end