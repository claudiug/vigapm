class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :city
      t.string :country
      t.text :bio

      t.timestamps
    end
  end
end
