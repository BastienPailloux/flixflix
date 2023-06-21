class ChangeFormatTypeMovieLengthMovieRating < ActiveRecord::Migration[7.0]
  def change
    change_column(:movies, :rating, :float)
    change_column(:movies, :length, :string)
  end
end
