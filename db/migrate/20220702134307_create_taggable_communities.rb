class CreateTaggableCommunities < ActiveRecord::Migration[7.0]
  def change
    create_table :taggable_communities do |t|
      t.belongs_to :community, null: false, foreign_key: true
      t.belongs_to :tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
