class CreatePolls < ActiveRecord::Migration
  def up
    create_table :polls do |t|
      t.string "title"
      t.string "type"

      t.timestamps
    end
  end

  def down
  	drop_table :polls
  end
end
