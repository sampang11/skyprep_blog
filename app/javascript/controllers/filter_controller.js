// app/javascript/controllers/filter_controller.js
import { Controller } from "stimulus"

export default class extends Controller {
  connect() {
    this.element.addEventListener("ajax:success", this.handleSuccess.bind(this))
  }

  handleSuccess(event) {
    const [data, status, xhr] = event.detail
    const turboStream = xhr.getResponseHeader("Turbo-Stream")
    if (turboStream) {
      const turboStreamElement = document.createElement("template")
      turboStreamElement.innerHTML = turboStream
      document.head.appendChild(turboStreamElement.content.cloneNode(true))
    }
  }
}
