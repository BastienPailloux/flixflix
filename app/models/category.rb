class Category < ApplicationRecord
  has_many :had_categories
  has_many :movies, through: :had_categories
end
