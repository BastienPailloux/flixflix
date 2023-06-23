class MoviesController < ApplicationController
  before_action :set_movie, only: %i[show]
  def index
    @movies = Movie.with_category
  end

  def show
    @categories = @movie.categories
  end

  def new
    @movie = Movie.new(movie_params)
    @categories = params[:category][:categories]
    respond_to do |format|
      format.text { render partial: 'movies/movie', locals: { movie: @movie, categories: @categories }, formats: [:html] }
    end
  end

  def create
    @categories = params[:categories][:categories]
    @movie = Movie.new(movie_params)
    @categories.each do |category|
      @movie.categories << Category.find_by(name: category)
    end
    if @movie.save!
      respond_to do |format|
        format.json { render json: @movie }
      end
    else
      respond_to do |format|
        format.json { render json: { error: 'error' } }
      end
    end
  end

  def get_movie_details
    allocine_url = params[:allocine_url]
    @movie = ::Scrapper::ScrapperService.new.scrapper(allocine_url)
    respond_to do |format|
      format.json { render json: @movie }
    end
  end

  def add_to_whishlist
    @wishlist = Whishlist.new(user: current_user)
    @movie = Movie.find_by(title: params[:movie_name])
    @wishlist.movie = @movie
    @wishlist.save!
    respond_to do |format|
      format.json { render json: @movie }
    end
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :rating, :number_of_votes, :length, :description, :realisator, :actors, :trailer_url, :image_url)
  end

  def set_movie
    @movie = Movie.find(params[:id])
  end
end
