class CreateRatings < ActiveRecord::Migration[5.2]

  def change
    create_table :ratings do |t|
      t.references :ratingable, null: false, polymorphic: true
      t.references :user,       null: false, foreign_key: true
      t.integer    :mark,       null: false
      t.timestamps
    end
  end
end
