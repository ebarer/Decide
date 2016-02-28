class CreateMovies < ActiveRecord::Migration
  def up
    create_table :movies do |t|
   	  t.integer "option_id"
   	  t.float "rating"
   	  t.string "length"
   	  t.string "genre"
   	  t.datetime "times"
   	  t.string "location"
   	  t.string "plot"
   	  t.string "poster"

      t.timestamps null: false
    end
  end

  def down
    drop_table :movies
  end
end

