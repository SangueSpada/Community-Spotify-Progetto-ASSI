class CreateUserReccomendations < ActiveRecord::Migration[7.0]
  def change
    create_table :user_reccomendations do |t|

      t.string :body
      t.string :resource_img
      t.boolean :viewed

      t.references :resource, null: false
      t.references :user, null: false

      t.timestamps
    end
  end
end
