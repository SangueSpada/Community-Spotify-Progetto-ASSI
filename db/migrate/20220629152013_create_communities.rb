class CreateCommunities < ActiveRecord::Migration[7.0]
  def change
    create_table :communities do |t|
      t.string :name, null: false, default: '', unique: true
      t.string :creator, null: false, default: ''
      t.string :description, null: false, default: ''
      t.string :playlist, null: false, default: '', unique: true

      t.timestamps
    end
  end
end
