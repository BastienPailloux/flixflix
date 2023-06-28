class Movie < ApplicationRecord
  has_many :had_categories
  has_many :categories, through: :had_categories
  has_many :whishlists
  has_many :users, through: :whishlists

  scope :with_category, lambda { |category_id|
    joins(:had_categories)
      .where("had_categories.category_id = ?", category_id)
  }

  scope :wishlisted, lambda { |current_user|
    joins(:whishlists)
      .where("whishlists.user_id = ?", current_user.id)
  }
end
