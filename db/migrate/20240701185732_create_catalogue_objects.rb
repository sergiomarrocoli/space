class CreateCatalogueObjects < ActiveRecord::Migration[7.1]
  def change
    create_table :catalogue_objects do |t|
      t.string :name, null: false
      t.string :object_type, null: false
      t.string :ra, null: true
      t.string :dec, null: true
      t.decimal :ra_decimal, null: true, precision: 9, scale: 6
      t.decimal :dec_decimal, null: true, precision: 9, scale: 6
      t.string :constellation, null: true
      t.string :common_name, null: true
      t.string :identifiers, null: true
      t.decimal :surface_brightness, null: true, precision: 5, scale: 2

      t.timestamps
    end

    add_index :catalogue_objects, :name, unique: true
  end
end
