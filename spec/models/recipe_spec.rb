require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let(:user) { User.create(
    email: 'test@example.com',
    password: 'password',
    password_confirmation: 'password'
    )
  }

  it 'should validate recipe_name' do
    recipe = user.recipes.create(
      description: "A classic Italian pasta dish with creamy sauce.",
      ingredients: ["Spaghetti", "Eggs", "Pancetta", "Parmesan Cheese", "Black Pepper"],
      instructions: "Cook spaghetti according to package instructions. In a separate pan, cook pancetta until crispy. In a bowl, whisk eggs, grated Parmesan cheese, and black pepper. Once spaghetti is cooked, drain and add to the pan with pancetta. Turn off heat, add egg mixture, and toss until coated and creamy. Serve immediately.",
      user_id: user.id,
      public: true
    )
    expect(recipe.errors[:recipe_name]).to include("can't be blank")
  end

  it 'should validate description' do
    recipe = user.recipes.create(
      recipe_name: "Spaghetti Carbonara",
      ingredients: ["Spaghetti", "Eggs", "Pancetta", "Parmesan Cheese", "Black Pepper"],
      instructions: "Cook spaghetti according to package instructions. In a separate pan, cook pancetta until crispy. In a bowl, whisk eggs, grated Parmesan cheese, and black pepper. Once spaghetti is cooked, drain and add to the pan with pancetta. Turn off heat, add egg mixture, and toss until coated and creamy. Serve immediately.",
      user_id: user.id,
      public: true
    )
    expect(recipe.errors[:description]).to include("can't be blank")
  end

  it 'should validate ingredients' do
    recipe = user.recipes.create(
      recipe_name: "Spaghetti Carbonara",
      description: "A classic Italian pasta dish with creamy sauce.",
      instructions: "Cook spaghetti according to package instructions. In a separate pan, cook pancetta until crispy. In a bowl, whisk eggs, grated Parmesan cheese, and black pepper. Once spaghetti is cooked, drain and add to the pan with pancetta. Turn off heat, add egg mixture, and toss until coated and creamy. Serve immediately.",
      user_id: user.id,
      public: true
    )
    expect(recipe.errors[:ingredients]).to include("can't be blank")
  end

  it 'should validate instructions' do
    recipe = user.recipes.create(
      recipe_name: "Spaghetti Carbonara",
      description: "A classic Italian pasta dish with creamy sauce.",
      ingredients: ["Spaghetti", "Eggs", "Pancetta", "Parmesan Cheese", "Black Pepper"],
      public: true
    )
    expect(recipe.errors[:instructions]).to include("can't be blank")
  end

  it 'should validate user_id' do
    recipe = Recipe.create(
      recipe_name: "Spaghetti Carbonara",
      description: "A classic Italian pasta dish with creamy sauce.",
      ingredients: ["Spaghetti", "Eggs", "Pancetta", "Parmesan Cheese", "Black Pepper"],
      instructions: "Cook spaghetti according to package instructions. In a separate pan, cook pancetta until crispy. In a bowl, whisk eggs, grated Parmesan cheese, and black pepper. Once spaghetti is cooked, drain and add to the pan with pancetta. Turn off heat, add egg mixture, and toss until coated and creamy. Serve immediately.",
      public: true
    )
    expect(recipe.errors[:user_id]).to include("can't be blank")
  end

  it 'should validate public' do
    recipe = user.recipes.create(
      recipe_name: "Spaghetti Carbonara",
      description: "A classic Italian pasta dish with creamy sauce.",
      ingredients: ["Spaghetti", "Eggs", "Pancetta", "Parmesan Cheese", "Black Pepper"],
      instructions: "Cook spaghetti according to package instructions. In a separate pan, cook pancetta until crispy. In a bowl, whisk eggs, grated Parmesan cheese, and black pepper. Once spaghetti is cooked, drain and add to the pan with pancetta. Turn off heat, add egg mixture, and toss until coated and creamy. Serve immediately.",
      user_id: user.id,
    )
    expect(recipe.errors[:public]).to include("can't be blank")
  end
end
