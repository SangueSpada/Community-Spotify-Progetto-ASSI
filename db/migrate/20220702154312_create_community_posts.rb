class CreateCommunityPosts < ActiveRecord::Migration[7.0]
  def change
    create_table :community_posts do |t|
      t.string :title
      t.string :body
      t.string :author
      t.references :community, null: false, foreign_key: true

      t.timestamps
    end
  end
end
