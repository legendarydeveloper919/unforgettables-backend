class RecipesController < ApplicationController
  def index
    recipes = Recipe.all.map { |recipe| recipe.as_json.merge(ingredients: recipe.ingredients) }
    render json: recipes
  end

  def create
    recipe = Recipe.create(recipe_params)
    if recipe.valid?
      render json: recipe
    else
      render json: recipe.errors, status: 422
    end
  end

  private
  def recipe_params
    params.require(:recipe).permit(:recipe_name, :ingredients, :instructions, :description, :user_id, :public)
  end
end
