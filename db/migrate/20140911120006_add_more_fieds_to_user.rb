class AddMoreFiedsToUser < ActiveRecord::Migration
  def change
    add_column :users, :city, :string
    add_column :users, :bio, :string
  end
end
