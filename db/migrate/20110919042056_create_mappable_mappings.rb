class CreateMappableMappings < ActiveRecord::Migration
  def change
    create_table :mappable_mappings do |t|
      t.string :from
      t.string :to
      t.references :map

      t.timestamps
    end
    add_index :mappable_mappings, :map_id
  end
end
