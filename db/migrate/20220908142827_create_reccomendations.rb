class CreateReccomendations < ActiveRecord::Migration[7.0]
  def change
    create_table :reccomendations do |t|

      t.string :body

      t.integer :resource_id, null: false
      t.binary :resource_flag, null: false
      t.string :resource_img

      t.binary :viewed

      t.timestamps
    end
  end
end
