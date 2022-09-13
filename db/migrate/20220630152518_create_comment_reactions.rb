class CreateCommentReactions < ActiveRecord::Migration[7.0]
  def change
    create_table :comment_reactions do |t|
      t.boolean :like, null: false, default: ''
      t.references :comment, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
