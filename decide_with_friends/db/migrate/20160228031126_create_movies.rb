class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
   	  t.references :option
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
end

