class CreateUserReccomendations < ActiveRecord::Migration[7.0]
  def change
    create_table :user_reccomendations do |t|
      t.string :body

      t.integer :resource_id, null: false
      t.string :resource_img

      t.binary :viewed

      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
