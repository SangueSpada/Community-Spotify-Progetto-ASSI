class CreateTaggableUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :taggable_users do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
