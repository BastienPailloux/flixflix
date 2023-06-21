class Movie < ApplicationRecord
  has_many :had_categories
  has_many :categories, through: :categories
  has_many :whishlists
  has_many :users, through: :whishlists
end
