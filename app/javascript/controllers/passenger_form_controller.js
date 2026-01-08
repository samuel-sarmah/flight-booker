import { Controller } from "@hotwired/stimulus"

// Handles passenger form validation with real-time feedback
export default class extends Controller {
  static targets = ["name", "email", "field"]

  connect() {
    this.validateAll()
  }

  validateName(event) {
    const input = event.target
    const value = input.value.trim()

    if (value.length < 2) {
      this.showFieldError(input, "Name must be at least 2 characters")
    } else if (!/^[a-zA-Z\s'-]+$/.test(value)) {
      this.showFieldError(input, "Please enter a valid name")
    } else {
      this.clearFieldError(input)
    }
  }

  validateEmail(event) {
    const input = event.target
    const value = input.value.trim()
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/

    if (!emailRegex.test(value)) {
      this.showFieldError(input, "Please enter a valid email address")
    } else {
      this.clearFieldError(input)
    }
  }

  validateAll() {
    this.nameTargets.forEach(input => {
      if (input.value) {
        this.validateName({ target: input })
      }
    })

    this.emailTargets.forEach(input => {
      if (input.value) {
        this.validateEmail({ target: input })
      }
    })
  }

  showFieldError(input, message) {
    input.classList.add("form-input--error")

    let errorEl = input.parentNode.querySelector(".form-error")
    if (!errorEl) {
      errorEl = document.createElement("div")
      errorEl.className = "form-error"
      input.parentNode.appendChild(errorEl)
    }
    errorEl.textContent = message
  }

  clearFieldError(input) {
    input.classList.remove("form-input--error")

    const errorEl = input.parentNode.querySelector(".form-error")
    if (errorEl) {
      errorEl.remove()
    }
  }
}
