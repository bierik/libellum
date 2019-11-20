class CreateFlatTemplate < ActiveRecord::Migration[5.2]
  def change
    create_table :flat_templates do |t|
      t.string :name
      t.float :price
    end
  end
end
