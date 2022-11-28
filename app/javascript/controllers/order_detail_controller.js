import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="order-detail"
export default class extends Controller {
  static targets = ["product", "productPrice", "quantity", "subtotal", "selected"]

  connect () {
    this.fetch_display_price(this.selectedTarget)
    this.fetch_subtotal()
    this.fetch_grand_total()
  }

  fetch_display_price(target) {
    let price = target.selectedOptions[0].dataset.price
    this.productPriceTarget.textContent = price
    this.fetch_subtotal()
  }

  fetch_subtotal() {
    this.subtotalTarget.textContent = (parseInt(this.quantityTarget.value) || 0) * parseInt(this.productPriceTarget.textContent)
  }

  fetch_grand_total() {
    let sum = parseInt(this.subtotalTarget.textContent)
    let total = parseInt(document.querySelector("#grandtotal").textContent)
    document.querySelector("#grandtotal").textContent = total + sum
  }

  display_product_price(event) {
    event.preventDefault()
    this.fetch_display_price(event.currentTarget)
  }
  display_subtotal(event) {
    event.preventDefault()
    this.fetch_subtotal()
  }
  add_to_total(event) {
    event.preventDefault()
    this.fetch_grand_total()

  }
  remove_from_total(event) {
    event.preventDefault()
    let sum = parseInt(this.subtotalTarget.textContent)
    let total = parseInt(document.querySelector("#grandtotal").textContent)
    document.querySelector("#grandtotal").textContent = total - sum
  }

}
