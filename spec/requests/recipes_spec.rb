require 'rails_helper'

RSpec.describe "Recipes", type: :request do
  let(:user) { User.create(
    email: 'test@example.com',
    password: 'password',
    password_confirmation: 'password'
    )
  }

  describe "GET /index" do
    it "gets a list of recipes" do
      recipe = user.recipes.create(
        recipe_name: "Spaghetti Carbonara",
        description: "A classic Italian pasta dish with creamy sauce.",
        ingredients: "Spaghetti, Eggs, Pancetta, Parmesan Cheese, Black Pepper",
        instructions: "Cook spaghetti according to package instructions. In a separate pan, cook pancetta until crispy. In a bowl, whisk eggs, grated Parmesan cheese, and black pepper. Once spaghetti is cooked, drain and add to the pan with pancetta. Turn off heat, add egg mixture, and toss until coated and creamy. Serve immediately.",
        public: true
      )
      get '/recipes'
    
      recipe = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(recipe.first['recipe_name']).to eq("Spaghetti Carbonara")
      expect(recipe.first['description']).to eq("A classic Italian pasta dish with creamy sauce.")
      expect(recipe.first['ingredients']).to eq("Spaghetti, Eggs, Pancetta, Parmesan Cheese, Black Pepper")
      expect(recipe.first['instructions']).to eq("Cook spaghetti according to package instructions. In a separate pan, cook pancetta until crispy. In a bowl, whisk eggs, grated Parmesan cheese, and black pepper. Once spaghetti is cooked, drain and add to the pan with pancetta. Turn off heat, add egg mixture, and toss until coated and creamy. Serve immediately.")
      expect(recipe.first['public']).to eq(true)
    end
  end

  describe "POST /create" do
    it "creates a new recipe" do
      recipe_params = {
        recipe: {
          recipe_name: "Spaghetti Carbonara",
          description: "A classic Italian pasta dish with creamy sauce.",
          ingredients: "Spaghetti, Eggs, Pancetta, Parmesan, Cheese, Black Pepper",
          instructions: "Cook spaghetti according to package instructions. In a separate pan, cook pancetta until crispy. In a bowl, whisk eggs, grated Parmesan cheese, and black pepper. Once spaghetti is cooked, drain and add to the pan with pancetta. Turn off heat, add egg mixture, and toss until coated and creamy. Serve immediately.",
          public: true,
          user_id: user.id
        }
      }
      
      post '/recipes', params: recipe_params
      recipe = Recipe.first
      expect(response).to have_http_status(200)
      
      expect(recipe["recipe_name"]).to eq("Spaghetti Carbonara")
      expect(recipe["description"]).to eq("A classic Italian pasta dish with creamy sauce.")
      expect(recipe["ingredients"]).to eq("Spaghetti, Eggs, Pancetta, Parmesan, Cheese, Black Pepper")
      expect(recipe["instructions"]).to eq("Cook spaghetti according to package instructions. In a separate pan, cook pancetta until crispy. In a bowl, whisk eggs, grated Parmesan cheese, and black pepper. Once spaghetti is cooked, drain and add to the pan with pancetta. Turn off heat, add egg mixture, and toss until coated and creamy. Serve immediately.")
      expect(recipe["public"]).to eq(true)
    end

    it "returns a 422 status code if recipe name is missing" do
      invalid_recipe = {
        recipe: {
          recipe_name: nil,
          description: "A classic Italian pasta dish with creamy sauce.",
          ingredients: "Spaghetti, Eggs, Pancetta, Parmesan, Cheese, Black Pepper",
          instructions: "Cook spaghetti according to package instructions. In a separate pan, cook pancetta until crispy. In a bowl, whisk eggs, grated Parmesan cheese, and black pepper. Once spaghetti is cooked, drain and add to the pan with pancetta. Turn off heat, add egg mixture, and toss until coated and creamy. Serve immediately.",
          public: true,
          user_id: user.id
        }
      }

      post "/recipes", params: invalid_recipe
      expect(response.status).to eq 422
      json = JSON.parse(response.body)
      expect(json["recipe_name"]).to include "can't be blank"
    end
  end

  describe "PUT /update" do
    it "updates a recipe" do
      recipe_params = {
        recipe: {
        recipe_name: "Spaghetti Carbonara",
        description: "A classic Italian pasta dish with creamy sauce.",
        ingredients: "Spaghetti Eggs, Pancetta, Parmesan Cheese, Black Pepper",
        instructions: "Cook spaghetti according to package instructions. In a separate pan, cook pancetta until crispy. In a bowl, whisk eggs, grated Parmesan cheese, and black pepper. Once spaghetti is cooked, drain and add to the pan with pancetta. Turn off heat, add egg mixture, and toss until coated and creamy. Serve immediately.",
        public: true,
        user_id:  user.id
    }
  }
    post "/recipes", params: recipe_params
    recipe=Recipe.last
    p recipe
      updated_recipe_params =  {
        recipe: {
          recipe_name: "Spaghetti",
          
          ingredients: "Spaghetti",
          instructions: "Cook spaghetti.",
          
          
        }
      }
       patch "/recipes/#{recipe.id}", params: updated_recipe_params


        

        expect(response).to have_http_status(200)

        updated_recipe = Recipe.find(recipe.id)
        p updated_recipe

        expect(updated_recipe.recipe_name).to eq "Spaghetti"
        
        expect(updated_recipe.ingredients).to eq "Spaghetti"
        expect(updated_recipe.instructions).to eq "Cook spaghetti."
        

    end
    it 'returns a 422 status code' do
      recipe_params = {
        recipe: {
          recipe_name: "Spaghetti Carbonara",
          description: "A classic Italian pasta dish with creamy sauce.",
          ingredients: "Spaghetti Eggs, Pancetta, Parmesan Cheese, Black Pepper",
          instructions: "Cook spaghetti according to package instructions. In a separate pan, cook pancetta until crispy. In a bowl, whisk eggs, grated Parmesan cheese, and black pepper. Once spaghetti is cooked, drain and add to the pan with pancetta. Turn off heat, add egg mixture, and toss until coated and creamy. Serve immediately.",
          public: true,
          user_id:  user.id
        }
      }

      post "/recipes", params: recipe_params
      recipe=Recipe.last
      p recipe
        invalid_recipe_params =  {
          recipe: {
            recipe_name: nil,
            
            ingredients: nil,
            instructions: nil,
            
            
          }
        }

      recipe = Recipe.last
      patch "/recipes/#{recipe.id}", params: invalid_recipe_params

      expect(response).to have_http_status(422)
      
    end
  end

  describe "DELETE /destroy" do
    it "deletes a recipe" do
      recipe = Recipe.create(
        recipe_name: "Spaghetti Carbonara",
        description: "A classic Italian pasta dish with creamy sauce.",
        ingredients: "Spaghetti, Eggs, Pancetta, Parmesan, Cheese, Black Pepper",
        instructions: "Cook spaghetti according to package instructions. In a separate pan, cook pancetta until crispy. In a bowl, whisk eggs, grated Parmesan cheese, and black pepper. Once spaghetti is cooked, drain and add to the pan with pancetta. Turn off heat, add egg mixture, and toss until coated and creamy. Serve immediately.",
        public: true,
        user_id: user.id
      )

      delete "/recipes/#{recipe.id}"

      expect(response).to have_http_status(:no_content)
      expect(Recipe.find_by(id: recipe.id)).to be_nil
    end
  end
end
