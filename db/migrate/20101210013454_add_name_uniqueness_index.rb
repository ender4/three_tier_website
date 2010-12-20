class AddNameUniquenessIndex < ActiveRecord::Migration
  def self.up
    add_index :pages, :name, :unique => true
  end

  def self.down
    remove_index :pages, :name
  end
end
