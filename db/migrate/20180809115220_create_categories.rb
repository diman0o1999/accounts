class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string  :name,          null: false
      t.string  :description
      t.integer :type_of,       null: false, default: 0
      t.boolean :is_available,  null: false, default: true
      t.timestamps
    end
  end
end
