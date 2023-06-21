class CreateMovies < ActiveRecord::Migration[7.0]
  def change
    create_table :movies do |t|
      t.string :title
      t.integer :rating
      t.integer :number_of_votes
      t.integer :length
      t.string :description
      t.string :realisator
      t.string :actors
      t.string :trailer_url

      t.timestamps
    end
  end
end
