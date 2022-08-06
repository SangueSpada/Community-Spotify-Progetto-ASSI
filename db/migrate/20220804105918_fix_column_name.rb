class FixColumnName < ActiveRecord::Migration[7.0]
  def self.up
    rename_column :posts, :title, :spotify_content
  end

  def self.down
  end
end
