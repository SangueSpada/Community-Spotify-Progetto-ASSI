class CreateParticipations < ActiveRecord::Migration[7.0]
  def change
    create_table :participations do |t|
      t.belongs_to :community 
      t.belongs_to :user

      t.integer :recc_id
      t.integer :role, default: 0
      t.boolean :banned, default: false

      t.timestamps
    end
  end
end
