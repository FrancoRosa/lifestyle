class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.references :autor, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.string :title
      t.string :text

      t.timestamps
    end
  end
end
