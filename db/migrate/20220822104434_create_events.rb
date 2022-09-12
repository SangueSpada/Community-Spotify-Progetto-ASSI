class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :title, null: false, default: ''
      t.text :body
      t.date :start_date, null: false, default: ''
      t.integer :community_id
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
