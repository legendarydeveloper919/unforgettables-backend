class RecipesController < ApplicationController
  def index
    recipes = Recipe.all.map { |recipe| recipe.as_json.merge(ingredients: recipe.ingredients) }
    render json: recipes
  end
end
