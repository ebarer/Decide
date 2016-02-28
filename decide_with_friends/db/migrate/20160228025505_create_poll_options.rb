class CreatePollOptions < ActiveRecord::Migration
  def up
    create_table :poll_options do |t|
      t.references :poll
      t.references :option
      t.boolean "winning_poll", :default => false
      t.integer "votes", :default => 0
      t.string "user_ids"

      t.timestamps null: false
    end
    add_index :poll_options, ["poll_id", "option_id"]
  end

  def down
  	drop_table :poll_options
  end
end
