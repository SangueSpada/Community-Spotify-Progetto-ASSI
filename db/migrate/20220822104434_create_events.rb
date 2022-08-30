class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :title
      t.text :body
      t.date :start_date
      t.time :start_time

      t.integer :community_id
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
