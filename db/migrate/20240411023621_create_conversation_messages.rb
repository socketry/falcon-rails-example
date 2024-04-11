class CreateConversationMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :conversation_messages do |t|
      t.belongs_to :conversation, null: false, foreign_key: true

      t.json :context
      t.text :prompt
      t.text :response
      t.timestamps
    end
  end
end
