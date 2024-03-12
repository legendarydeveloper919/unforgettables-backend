class Recipe < ApplicationRecord
  belongs_to :user
  validates :recipe_name, :ingredients, :instructions, :description, presence: true
  validates :user_id, presence: true
  
  validates :public, inclusion: { in: [true, false] }




  validates_associated :user

  
end
