class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :spotify_content, null: false, default: ''
      t.string :body, null: false, default: ''
      t.integer :community_id, null: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
