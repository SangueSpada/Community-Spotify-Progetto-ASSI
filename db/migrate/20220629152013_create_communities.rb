class CreateCommunities < ActiveRecord::Migration[7.0]
  def change
    create_table :communities do |t|
      t.string :name
      t.string :creator
      t.string :description
      t.string :playlist

      t.timestamps
    end
  end
end
