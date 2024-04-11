class CreateConversations < ActiveRecord::Migration[7.1]
  def change
    create_table :conversations do |t|
      t.string "model", null: false
      t.timestamps
    end
  end
end
