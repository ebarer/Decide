class CreateUserPolls < ActiveRecord::Migration
  def up
    create_table :user_polls do |t|
      t.references :user
      t.references :poll
      t.boolean "admin", :default => false

      t.timestamps
    end
    add_index :user_polls, ["user_id", "poll_id"]
  end

  def down
  	drop_table :user_polls
  end
end
