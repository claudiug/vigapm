class CreatePictures < ActiveRecord::Migration
  def change
    create_table :post_pictures do |t|
      t.belongs_to :post

      t.timestamps
    end
    add_index :post_pictures, :post_id

    reversible do |dir|
      dir.up do
        add_attachment :post_pictures, :image
        remove_attachment :posts, :images
      end

      dir.down do
        remove_attachment :post_pictures, :image
        add_attachment :posts, :images
      end
    end
  end
end
