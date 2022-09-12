class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.text :body, null: false, default: ''
      t.references :chat, index: true
      t.references :user, index: true
      t.timestamps
    end
  end
end
