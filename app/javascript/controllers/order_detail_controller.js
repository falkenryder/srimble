import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="order-detail"
export default class extends Controller {
  static targets = ["product", "productPrice", "quantity", "subtotal", "selected"]


  connect () {
    this.fetch_display_price(this.selectedTarget)
    this.fetch_subtotal()
    this.fetch_grand_total_add()
  }
  convert_to_currency(num) {
  let formatter = new Intl.NumberFormat('en-US', {
    style: 'currency',
    currency: 'USD',
  });
  return formatter.format(num)
  }
  convert_to_float(str) {
    return Number(str.replace(/[^0-9\.-]+/g,""));
  }
  fetch_display_price(target) {
    let price = target.selectedOptions[0].dataset.price
    this.productPriceTarget.textContent = this.convert_to_currency(price)
  }

  remove_quantity() {
    this.quantityTarget.value = 0
  }

  get_subtotal() {
    let price = this.convert_to_float(this.productPriceTarget.textContent)
    let subtotal = (parseInt(this.quantityTarget.value) || 0) * price
    this.subtotalTarget.value = subtotal
  }

  fetch_subtotal() {
    let price = this.convert_to_float(this.productPriceTarget.textContent)
    let subtotal = (parseInt(this.quantityTarget.value) || 0) * price
    this.subtotalTarget.textContent = this.convert_to_currency(subtotal)
  }

  fetch_grand_total_add() {
    let subtotal = this.subtotalTarget.value || 0
    let sum = this.convert_to_float(this.subtotalTarget.textContent)
    let total = this.convert_to_float(document.querySelector("#grandtotal").textContent)
    document.querySelector("#grandtotal").textContent = this.convert_to_currency(total - subtotal + sum)
  }
  fetch_grand_total_remove() {
    let sum = this.convert_to_float(this.subtotalTarget.textContent)
    let total = this.convert_to_float(document.querySelector("#grandtotal").textContent)
    document.querySelector("#grandtotal").textContent = this.convert_to_currency(total - sum)
  }


  display_product_price(event) {
    event.preventDefault()
    this.fetch_grand_total_remove()
    this.remove_quantity()
    this.fetch_display_price(event.currentTarget)
    this.fetch_subtotal()
    this.get_subtotal()
    this.fetch_grand_total_add()
  }

  display_subtotal(event) {
    event.preventDefault()
    this.fetch_subtotal()
  }
  add_to_total(event) {
    event.preventDefault()
    this.fetch_grand_total_add()
  }
  remove_from_total(event) {
    event.preventDefault()
    this.fetch_grand_total_remove()
  }
}
