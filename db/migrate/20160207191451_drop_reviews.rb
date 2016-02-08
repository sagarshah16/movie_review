class DropReviews < ActiveRecord::Migration
def up
    drop_table :reviews
  end

  def down
    create_table :reviews do |t|
     
    t.integer  :rating
    t.text     :comment
    t.integer  :user_id
    t.integer  :movie

      t.timestamps        
    end
    add_index :reviews
  end
end
 