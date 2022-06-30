class CreateCommentReactions < ActiveRecord::Migration[7.0]
  def change
    create_table :comment_reactions do |t|
      t.string :uid
      t.boolean :like
      t.references :comment, null: false, foreign_key: true

      
      t.timestamps
    end
  end
end
