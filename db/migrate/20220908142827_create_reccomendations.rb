class CreateReccomendations < ActiveRecord::Migration[7.0]
  def change
    create_table :reccomendations do |t|

      t.string :body

      t.integer :resource_id
      t.binary :resource_flag

      t.binary :viewed

      t.timestamps
    end
  end
end
