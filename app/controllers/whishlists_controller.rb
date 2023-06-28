class WhishlistsController < ApplicationController
  def index
    @movies = Movie.wishlisted(current_user)
  end
end
