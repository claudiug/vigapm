class Add < ActiveRecord::Migration
  def change
    add_attachment :posts, :images
  end
end
