class AddNameUrlToPages < ActiveRecord::Migration
  def self.up
    add_column :pages, :name_url, :string
    add_index :pages, :name_url, :unique => true
  end

  def self.down
    remove_index :pages, :name_url
    remove_column :pages, :name_url
  end
end
