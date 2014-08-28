class FixForUserId < ActiveRecord::Migration
  def change
    add_column :profiles, :user_id, :integer
    add_index :profiles, :user_id, unique: true, name: 'user_profile_index'
  end
end
