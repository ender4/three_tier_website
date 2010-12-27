class AddNameUrlToPhotos < ActiveRecord::Migration
  def self.up
    add_column :photos, :name_url, :string
    add_index :photos, :name_url, :unique => true
  end

  def self.down
    remove_index :photos, :name_url
    remove_column :photos, :name_url
  end
end
