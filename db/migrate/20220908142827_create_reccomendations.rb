class CreateReccomendations < ActiveRecord::Migration[7.0]
  def change
    create_table :reccomendations do |t|

      t.integer :id_reference
      t.binary :flag

      t.timestamps
    end
  end
end
