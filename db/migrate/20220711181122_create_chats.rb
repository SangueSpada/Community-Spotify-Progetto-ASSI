class CreateChats < ActiveRecord::Migration[7.0]
  def change
    create_table :chats do |t|

      t.string :user1
      t.string :user2
      
      
      t.timestamps
    end
  end
end
