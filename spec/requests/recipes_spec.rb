require 'rails_helper'

RSpec.describe "Recipes", type: :request do
  let(:user) { User.create(
    email: 'test@example.com',
    password: 'password',
    password_confirmation: 'password'
    )
  }

  describe "GET /index" do
    it 'gets a list of recipes' do
      recipe = user.recipes.create(
        recipe_name: "Spaghetti Carbonara",
        description: "A classic Italian pasta dish with creamy sauce.",
        ingredients: ["Spaghetti", "Eggs", "Pancetta", "Parmesan Cheese", "Black Pepper"],
        instructions: "Cook spaghetti according to package instructions. In a separate pan, cook pancetta until crispy. In a bowl, whisk eggs, grated Parmesan cheese, and black pepper. Once spaghetti is cooked, drain and add to the pan with pancetta. Turn off heat, add egg mixture, and toss until coated and creamy. Serve immediately.",
        public: true
      )
      get '/recipes'
    
      recipe = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(recipe.first['recipe_name']).to eq("Spaghetti Carbonara")
      expect(recipe.first['description']).to eq("A classic Italian pasta dish with creamy sauce.")
      expect(JSON.parse(recipe.first['ingredients'])).to eq(["Spaghetti", "Eggs", "Pancetta", "Parmesan Cheese", "Black Pepper"]) # Modified line
      expect(recipe.first['instructions']).to eq("Cook spaghetti according to package instructions. In a separate pan, cook pancetta until crispy. In a bowl, whisk eggs, grated Parmesan cheese, and black pepper. Once spaghetti is cooked, drain and add to the pan with pancetta. Turn off heat, add egg mixture, and toss until coated and creamy. Serve immediately.")
      expect(recipe.first['public']).to eq(true)
    end
  end

  it 'creates a new recipe' do
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

  it "can't create without a recipe name" do
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


  it "can't create without a description" do
    invalid_recipe = {
      recipe: {
        recipe_name: "Spaghetti Carbonara",
        description: nil,
        ingredients: "Spaghetti, Eggs, Pancetta, Parmesan, Cheese, Black Pepper",
        instructions: "Cook spaghetti according to package instructions. In a separate pan, cook pancetta until crispy. In a bowl, whisk eggs, grated Parmesan cheese, and black pepper. Once spaghetti is cooked, drain and add to the pan with pancetta. Turn off heat, add egg mixture, and toss until coated and creamy. Serve immediately.",
        public: true,
        user_id: user.id
      }
    }

    post "/recipes", params: invalid_recipe
    expect(response.status).to eq 422
    json = JSON.parse(response.body)
    expect(json["description"]).to include "can't be blank"
  end

  it "can't create without an ingredient list" do
    invalid_recipe = {
      recipe: {
        recipe_name: "Spaghetti Carbonara",
        description: "A classic Italian pasta dish with creamy sauce.",
        ingredients: nil,
        instructions: "Cook spaghetti according to package instructions. In a separate pan, cook pancetta until crispy. In a bowl, whisk eggs, grated Parmesan cheese, and black pepper. Once spaghetti is cooked, drain and add to the pan with pancetta. Turn off heat, add egg mixture, and toss until coated and creamy. Serve immediately.",
        public: true,
        user_id: user.id
      }
    }

    post "/recipes", params: invalid_recipe
    expect(response.status).to eq 422
    json = JSON.parse(response.body)
    expect(json["ingredients"]).to include "can't be blank"
  end

  it "can't create without instructions" do
    invalid_recipe = {
      recipe: {
        recipe_name: "Spaghetti Carbonara",
        description: "A classic Italian pasta dish with creamy sauce.",
        ingredients: "Spaghetti, Eggs, Pancetta, Parmesan, Cheese, Black Pepper",
        instructions: nil,
        public: true,
        user_id: user.id
      }
    }

    post "/recipes", params: invalid_recipe
    expect(response.status).to eq 422
    json = JSON.parse(response.body)
    expect(json["instructions"]).to include "can't be blank"
  end

  it "can't create without a public true/false" do
    invalid_recipe = {
      recipe: {
        recipe_name: "Spaghetti Carbonara",
        description: "A classic Italian pasta dish with creamy sauce.",
        ingredients: "Spaghetti, Eggs, Pancetta, Parmesan, Cheese, Black Pepper",
        instructions: "S",
        public: nil,
        user_id: user.id
      }
    }

    post "/recipes", params: invalid_recipe
    expect(response.status).to eq 422
    json = JSON.parse(response.body)
    expect(json["public"]).to include "can't be blank"
  end

  it "must have a user_id" do
    invalid_recipe = {
      recipe: {
        recipe_name: "Spaghetti Carbonara",
        description: "A classic Italian pasta dish with creamy sauce.",
        ingredients: "Spaghetti, Eggs, Pancetta, Parmesan, Cheese, Black Pepper",
        instructions: "S",
        public: false,
        user_id: nil
      }
    }

    post "/recipes", params: invalid_recipe
    expect(response.status).to eq 422
    json = JSON.parse(response.body)
    expect(json["user_id"]).to include "can't be blank"
  end
end