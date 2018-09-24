class CreateReports < ActiveRecord::Migration[5.2]
  def change
    create_table :reports do |t|
      t.references :user,     null: false, foreign_key: true
      t.references :article,  null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.text       :body,     null: true
      t.timestamps
    end
  end
end
