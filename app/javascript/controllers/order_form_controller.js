import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="order-form"
export default class extends Controller {
  static targets = ["add_detail", "template", "product", "productPrice"]

  add_association(event) {
    event.preventDefault()
    const content = this.templateTarget.innerHTML.replace(/TEMPLATE_RECORD/g, Math.floor(Math.random() * 20 ))
    this.add_detailTarget.insertAdjacentHTML('beforebegin', content)
  }

  remove_association(event) {
    event.preventDefault()

    let item = event.target.closest(".nested-fields")
    item.querySelector("input[name*='_destroy']").value = 1
    item.style.display = "none"
  }

  display_product_price(event) {
    event.preventDefault()
    console.log("hello")

  }
}
