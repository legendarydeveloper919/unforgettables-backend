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
end