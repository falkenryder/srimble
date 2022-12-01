import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["status"]

  connect() {
    console.log(this.statusTarget.textContent)
    this.change_status_color(this.statusTarget)
  }

  change_status_color(target) {
    let status = target.textContent
    let klass = target.classList.item(2)
    switch (status) {
      default:
        target.classList.remove(klass)
        target.classList.add("pending-badge");;
        break;
        case "confirmed":
          target.classList.remove(klass)
          target.classList.add("confirmed-badge");
          break;
          case "delivered":
          target.classList.remove(klass)
          target.classList.add("delivered-badge");
    }
  }
}
