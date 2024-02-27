class Recipe < ApplicationRecord
  belongs_to :user
  validates :recipe_name, :ingredients, :instructions, :description, :user_id, :public, presence: true
end
