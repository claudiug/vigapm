class AddGuruToPost < ActiveRecord::Migration
  def change
    add_column :posts, :guru_id, :integer
    add_index :posts, :guru_id

    Post.all.map { |post| post.update(guru: post.user) }
  end
end
