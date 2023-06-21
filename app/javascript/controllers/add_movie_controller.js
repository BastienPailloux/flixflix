import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="add-movie"
export default class extends Controller {
  static targets = ['modal', 'title']

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
      this.#displayMovie(data)
    })
  }

  #displayMovie(movie_data) {

  }
}
