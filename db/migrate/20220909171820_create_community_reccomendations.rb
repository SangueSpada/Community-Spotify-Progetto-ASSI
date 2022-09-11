class CreateCommunityReccomendations < ActiveRecord::Migration[7.0]
  def change
    create_table :community_reccomendations do |t|

      t.string :body
      t.string :resource_img
      t.boolean :viewed

      t.references :community, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      
      t.timestamps
    end
  end
end
