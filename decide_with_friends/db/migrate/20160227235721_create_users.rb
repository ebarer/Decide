class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.bigint "fb_id"
      t.string "profilePicture"
      t.string "first_name", :limit => 50, :null => false
      t.string "last_name", :limit => 50, :null => false
      t.string "email", :default => "", :limit => 50, :null => false

      t.timestamps null: false
    end
  end

  def down
  	drop_table :users
  end
end