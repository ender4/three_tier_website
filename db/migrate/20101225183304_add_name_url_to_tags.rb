class AddNameUrlToTags < ActiveRecord::Migration
  def self.up
    add_column :tags, :name_url, :string
    add_index :tags, :name_url, :unique => true
  end

  def self.down
    remove_index :tags, :name_url
    remove_column :tags, :name_url
  end
end
