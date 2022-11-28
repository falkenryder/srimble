import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="order-detail"
export default class extends Controller {
  static targets = ["product", "productPrice", "quantity", "subtotal"]

  connect() {
    console.log('order detail connected');
    this.productPriceTarget.textContent = this.productTarget.dataset.price
  }

  display_product_price(event) {
    event.preventDefault()
    console.log(this.currentTarget)
    // this.productTargets.forEach((target) => {console.log(target.dataset)})
    this.productPriceTarget.textContent = this.productTarget.dataset.price

  }
  display_subtotal(event) {
    event.preventDefault()
    this.subtotalTarget.textContent = (parseInt(this.quantityTarget.value) || 0) * parseInt(this.productTarget.dataset.price)

  }
  add_to_total(event) {
    event.preventDefault()
    let sum = parseInt(this.subtotalTarget.textContent)
    let total = parseInt(document.querySelector("#grandtotal").textContent)
    document.querySelector("#grandtotal").textContent = total + sum

  }
  remove_from_total(event) {
    event.preventDefault()
    let sum = parseInt(this.subtotalTarget.textContent)
    let total = parseInt(document.querySelector("#grandtotal").textContent)
    document.querySelector("#grandtotal").textContent = total - sum
  }


}
