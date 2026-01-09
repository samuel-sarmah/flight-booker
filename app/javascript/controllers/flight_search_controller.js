import { Controller } from "@hotwired/stimulus"

// Handles flight search form with real-time validation
export default class extends Controller {
  static targets = ["departure", "arrival", "date", "passengers", "submit", "swapBtn"]

  connect() {
    this.validate()
    
    // Auto-scroll to results after search
    this.scrollToResults()
  }

  validate() {
    const departure = this.departureTarget.value
    const arrival = this.arrivalTarget.value
    const date = this.dateTarget.value

    // Check if departure and arrival are the same
    if (departure && arrival && departure === arrival) {
      this.arrivalTarget.classList.add("form-input--error")
      this.showError("Departure and arrival airports cannot be the same")
    } else {
      this.arrivalTarget.classList.remove("form-input--error")
      this.clearError()
    }

    // Enable/disable submit button
    const isValid = departure && arrival && date && departure !== arrival
    this.submitTarget.disabled = !isValid
  }

  swap(event) {
    event.preventDefault()
    const departure = this.departureTarget.value
    const arrival = this.arrivalTarget.value

    // Animate the swap
    this.swapBtnTarget.classList.add("rotating")

    this.departureTarget.value = arrival
    this.arrivalTarget.value = departure

    setTimeout(() => {
      this.swapBtnTarget.classList.remove("rotating")
    }, 300)

    this.validate()
  }

  scrollToResults() {
    // Check if we have search parameters (indicating a search was performed)
    const urlParams = new URLSearchParams(window.location.search)
    const hasSearchParams = urlParams.has('departure_airport_id') || 
                          urlParams.has('arrival_airport_id') || 
                          urlParams.has('startdatetime')

    if (hasSearchParams) {
      // Wait for Turbo frame to load, then scroll to results
      setTimeout(() => {
        const resultsFrame = document.getElementById('flight-results')
        if (resultsFrame) {
          resultsFrame.scrollIntoView({ 
            behavior: 'smooth', 
            block: 'start' 
          })
          
          // Add a subtle highlight effect
          resultsFrame.classList.add('results-highlighted')
          setTimeout(() => {
            resultsFrame.classList.remove('results-highlighted')
          }, 2000)
        }
      }, 100)
    }
  }

  showError(message) {
    let errorEl = this.element.querySelector(".form-error")
    if (!errorEl) {
      errorEl = document.createElement("div")
      errorEl.className = "form-error mt-sm"
      this.arrivalTarget.parentNode.appendChild(errorEl)
    }
    errorEl.textContent = message
  }

  clearError() {
    const errorEl = this.element.querySelector(".form-error")
    if (errorEl) {
      errorEl.remove()
    }
  }
}
