class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.references :user,  null: false, foreign_key: true
      t.string     :title, null: false
      t.string     :ip,    null: false
      t.text       :text,  null: false
      t.integer    :rating,null: false, default: 0
      t.timestamps
    end
  end
end
