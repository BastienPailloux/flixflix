import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="add-movie"
export default class extends Controller {
  static targets = ['modal', 'title', 'new', 'buttons']

  connect() {
  }

  displayBox(event) {
    event.preventDefault();
    this.modalTarget.classList.remove('d-none')
  }

  findMovie(event) {
    event.preventDefault();
    let allocine_url = this.titleTarget.value
    let token = document.getElementsByName('csrf-token')[0].content;
    fetch('/movies/get_movie_details', {
      method: "POST",
      headers: {'accept': 'application/json',
                  'Content-Type': 'application/json',
                  'X-CSRF-Token': token},
      body: JSON.stringify({'allocine_url': allocine_url})
    })
    .then(response => response.json())
    .then((data) => {
      this.movie_data = data
      this.#createCategory(data)
    })
  }

  #createCategory(data) {
    let token = document.getElementsByName('csrf-token')[0].content;
    let categories = data.categories
    categories.forEach((category) => {
      fetch('/categories', {
        method: "POST",
        headers : {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'X-CSRF-Token': token
        },
        body: JSON.stringify({'category': {'name': category}})
      })
      .then(response => response.json())
      .then((category_data) => {
      console.log(category_data)
      })
    })
    this.#displayMovie(data)
  }

  #displayMovie(movie_data) {
    let token = document.getElementsByName('csrf-token')[0].content;
    fetch('/movies/new?' + new URLSearchParams({
      'movie[title]': movie_data.title,
      'movie[description]': movie_data.description,
      'movie[rating]': movie_data.rating,
      'movie[number_of_votes]': movie_data.number_of_votes,
      'movie[realisator]': movie_data.direction,
      'movie[actors]': movie_data.casting,
      'movie[length]': movie_data.duration,
      'movie[image_url]': movie_data.image_url,
      'category[categories]': movie_data.categories,
    }), {
      headers: {
        "Accept": "text/plain",
        'X-CSRF-Token': token
      }
    })
    .then(response => response.text())
    .then((data) => {
      this.newTarget.innerHTML = data
      this.buttonsTarget.classList.remove('d-none')
    })
  }

  refuse(event) {
    event.preventDefault();
    this.newTarget.outerHTML = "<div data-add-movie-target='new'></div>"
    this.titleTarget.value = ""
  }

  add(event) {
    event.preventDefault();
    let token = document.getElementsByName('csrf-token')[0].content;
    let movie_title = this.movie_data.title
    let movie_description = this.movie_data.description
    let movie_rating = this.movie_data.rating
    let movie_number_of_votes = this.movie_data.number_of_votes
    let movie_realisator = this.movie_data.direction.toString()
    let movie_actors = this.movie_data.casting.toString()
    let movie_length = this.movie_data.duration
    let movie_categories = this.movie_data.categories
    let movie_image_url = this.movie_data.image_url
    fetch('/movies', {
      method: "POST",
      headers:  {
        'accept': 'application/json',
        'Content-Type': 'application/json',
        'X-CSRF-Token': token
      },
      body: JSON.stringify({
        'movie': {
          'title': movie_title,
          'description': movie_description,
          'rating': movie_rating,
          'number_of_votes': movie_number_of_votes,
          'realisator': movie_realisator,
          'actors': movie_actors,
          'length': movie_length,
          'image_url': movie_image_url
         },
        'categories':{
          'categories': movie_categories
        }
      })
    })
    .then(response => response.json())
    .then((data) => {
      console.log(data)
    })
  }
}
