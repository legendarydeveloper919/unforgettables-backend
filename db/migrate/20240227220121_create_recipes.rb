class CreateRecipes < ActiveRecord::Migration[7.1]
  def change
    create_table :recipes do |t|
      t.string :recipe_name
      t.string :description
      t.text :ingredients
      t.string :instructions
      t.string :user_id
      t.boolean :public

      t.timestamps
    end
  end
end
