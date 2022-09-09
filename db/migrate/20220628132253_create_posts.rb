class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :spotify_content
      t.string :body
      t.integer :community_id, null: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
