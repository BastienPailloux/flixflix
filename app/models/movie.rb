class Movie < ApplicationRecord
  has_many :had_categories
  has_many :categories, through: :had_categories
  has_many :whishlists
  has_many :users, through: :whishlists

  scope :with_category, ->(category_id) {
    where('category_id == ?', category_id) }
end
