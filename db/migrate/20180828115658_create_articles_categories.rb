class CreateArticlesCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :articles_categories do |t|
      t.references :category, null: false, foreign_key: true
      t.references :article,  null: false, foreign_key: true
      t.timestamps
    end
    add_index(:articles_categories, [:category_id, :article_id], unique: true)

  end
end
