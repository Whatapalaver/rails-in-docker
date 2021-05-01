class CreateMuseumObjects < ActiveRecord::Migration[5.2]
  def change
    create_table :museum_objects do |t|
      t.string :systemNumber
      t.string :objectType
      t.string :title
      t.string :image_id
      t.text :description

      t.timestamps
    end
  end
end
