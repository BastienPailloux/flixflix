class CategoriesController < ApplicationController
  def create
    @category = Category.find_or_create_by(category_params)
    respond_to do |format|
      format.json { render json: @category }
    end
  end

  def show
    @categories = Category.all
    @category = Category.find(params[:id])
    @movies = Movie.with_category(@category)
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
