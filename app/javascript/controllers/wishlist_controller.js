import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="wishlist"
export default class extends Controller {
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
}
