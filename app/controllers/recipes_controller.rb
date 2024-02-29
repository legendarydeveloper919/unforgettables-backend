class RecipesController < ApplicationController
  def index
    recipes = Recipe.all
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

  def update
    recipe = Recipe.find(params[:id])
    recipe.update(recipe_params)
    if recipe.valid?
      render json: recipe
    else 
      render json: recipe.errors, status: 422
    end
  end

  def destroy
    recipe = Recipe.find_by(id: params[:id])
    if recipe
      recipe.destroy
      head :no_content
    else
      render json: { error: 'Recipe not found' }, status: :not_found
    end
  end

  private
  def recipe_params
    params.require(:recipe).permit(:recipe_name, :ingredients, :instructions, :description, :user_id, :public)
  end
end
