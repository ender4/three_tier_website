class AddOrderToPages < ActiveRecord::Migration
  def self.up
    add_column :pages, :page_order, :integer
    add_index :pages, :page_order, :uniqueness => true, :default => 1
  end

  def self.down
    remove_index :pages, :page_order
    remove_column :pages, :page_order
  end
end
