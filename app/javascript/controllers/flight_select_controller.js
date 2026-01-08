import { Controller } from "@hotwired/stimulus"

// Handles flight selection with visual feedback
export default class extends Controller {
  static targets = ["card", "radio", "submit"]
  static classes = ["selected"]

  connect() {
    this.updateSelection()
  }

  select(event) {
    const card = event.currentTarget
    const radio = card.querySelector('input[type="radio"]')

    if (radio) {
      radio.checked = true
      this.updateSelection()
    }
  }

  updateSelection() {
    // Remove selected class from all cards
    this.cardTargets.forEach(card => {
      card.classList.remove("flight-card--selected")
    })

    // Add selected class to the checked card
    const checkedRadio = this.element.querySelector('input[type="radio"]:checked')
    if (checkedRadio) {
      const selectedCard = checkedRadio.closest(".flight-card")
      if (selectedCard) {
        selectedCard.classList.add("flight-card--selected")
      }
      this.submitTarget.disabled = false
    } else {
      this.submitTarget.disabled = true
    }
  }
}
