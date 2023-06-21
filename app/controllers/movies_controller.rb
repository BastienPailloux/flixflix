class MoviesController < ApplicationController
  before_action :set_movie, only: %i[show]
  def index
    @movies = Movie.with_category
  end

  def show; end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save!
      respond_to do |format|
        format.json { render json: @movie }
      end
    else
      respond_to do |format|
        format.json { render json: {error: 'error'} }
      end
    end
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :rating, :number_of_votes, :length, :description, :realisator, :actors, :trailer_url)
  end

  def set_movie
    @movie = Movie.find(params[:id])
  end
end
