class CreateMappableMaps < ActiveRecord::Migration
  def change
    create_table :mappable_maps do |t|
      t.string :name
      t.string :from_mapping
      t.string :to_mapping
      t.string :mapping_attribute

      t.timestamps
    end
  end
end
