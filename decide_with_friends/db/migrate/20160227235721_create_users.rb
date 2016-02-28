class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string "profile_picture"
      t.string "first_name", :limit => 50
      t.string "last_name", :limit => 50
      t.string "email", :default => "", :limit => 50, :null => false

      t.timestamps null: false
    end
    add_column :users, "fb_id", :bigint
  end

  def down
  	drop_table :users
  end
end