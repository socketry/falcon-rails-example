class CreateConversationMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :conversation_messages do |t|
      t.jsonb :context
      t.text :prompt
      t.text :response
      t.timestamps
    end
  end
end
