class AddPropeRelationsUserProfile < ActiveRecord::Migration
  def change
    add_index :profiles, :user_id, unique: true, name: 'user_profile_index'
  end
end
