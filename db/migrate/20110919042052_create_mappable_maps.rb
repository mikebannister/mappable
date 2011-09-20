class CreateMappableMaps < ActiveRecord::Migration
  def change
    create_table :mappable_maps do |t|
      t.string :name
      t.string :from
      t.string :to
      t.string :attr

      t.timestamps
    end
  end
end
