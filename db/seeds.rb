users = [
  { username: "user1", email: "user1@example.com", password: "password" },
  { username: "user2", email: "user2@example.com", password: "password" },
  { username: "user3", email: "user3@example.com", password: "password" }
]

users.each do |user_data|
  user = User.create(user_data)
  puts "Creating user: #{user.username}"
end

recipes = [
  {
    recipe_name: "Spaghetti Carbonara",
    description: "A classic Italian pasta dish with creamy sauce.",
    ingredients: ["Spaghetti", "Eggs", "Pancetta", "Parmesan Cheese", "Black Pepper"],
    instructions: "Cook spaghetti according to package instructions. In a separate pan, cook pancetta until crispy. In a bowl, whisk eggs, grated Parmesan cheese, and black pepper. Once spaghetti is cooked, drain and add to the pan with pancetta. Turn off heat, add egg mixture, and toss until coated and creamy. Serve immediately.",
    user_id: User.find_by(username: "user1").id,
    public: true
  },
  {
    recipe_name: "Chicken Tikka Masala",
    description: "A popular Indian curry dish with tender chicken in a creamy tomato sauce.",
    ingredients: ["Chicken", "Yogurt", "Tomato Sauce", "Onion", "Garlic", "Ginger", "Spices"],
    instructions: "Marinate chicken in yogurt and spices. Grill or bake until cooked through. In a separate pan, sauté onions, garlic, and ginger until soft. Add tomato sauce and spices, then simmer. Add cooked chicken to the sauce and simmer until flavors meld. Serve with rice and naan.",
    user_id: User.find_by(username: "user2").id,
    public: true
  },
  {
    recipe_name: "Avocado Toast",
    description: "A simple and nutritious breakfast or snack option.",
    ingredients: ["Bread", "Avocado", "Lemon Juice", "Salt", "Red Pepper Flakes"],
    instructions: "Toast bread until golden brown. Mash avocado with lemon juice and salt. Spread avocado mixture on toast. Sprinkle with red pepper flakes. Enjoy!",
    user_id: User.find_by(username: "user3").id,
    public: false
  }
]

recipes.each do |recipe|
  Recipe.create(recipe)
  puts "Creating recipe: #{recipe[:recipe_name]}"
end