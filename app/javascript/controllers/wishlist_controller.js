import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="wishlist"
export default class extends Controller {
  static targets = ['hearth']

  connect() {
  }

  add(event) {
    event.preventDefault()
    let token = document.getElementsByName('csrf-token')[0].content;
    let movie_name = event.target.parentElement.children[1].textContent
    fetch('/movies/add_to_whishlist', {
      method: "POST",
      headers: {'accept': 'application/json',
                  'Content-Type': 'application/json',
                  'X-CSRF-Token': token},
      body: JSON.stringify({'movie_name': movie_name})
    })
    .then(response => response.json())
    .then((data) => {
      console.log(data)
    })
  }

  over(event) {
    event.target.classList.toggle('fa-regular')
    event.target.classList.add('fa-solid')
  }

  out(event) {
    event.target.classList.toggle('fa-solid')
    event.target.classList.add('fa-regular')
  }
}
