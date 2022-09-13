class CreateChats < ActiveRecord::Migration[7.0]
  def change
    create_table :chats do |t|

      t.references :user1
      t.references :user2
      
      t.datetime :last_message_at 
      t.timestamps
    end
  end
end
