import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    initialize() {}
    connect() {
        console.log("Controllore commenti")
    }
    toggleForm(event) {
        console.log("Cliccato il bottone di Modifica")
        event.preventDefault();
        event.stopPropagation();
        const formID = event.params["form"];
        const commentBodyID = event.params["body"];
        const form = document.getElementById(formID)
        form.classList.toggle("d-none")
        const commentBody = document.getElementById(commentBodyID)
        commentBody.classList.toggle("d-none")
    }
}