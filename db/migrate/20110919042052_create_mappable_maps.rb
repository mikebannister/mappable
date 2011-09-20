class CreateMappableMaps < ActiveRecord::Migration
  def change
    create_table :mappable_maps do |t|
      t.string :subject
      t.string :attr
      t.string :from
      t.string :to

      t.timestamps
    end
  end
end
