import { Controller } from "@hotwired/stimulus"

// Handles real-time form validation
export default class extends Controller {
  static targets = ["input", "submit"]

  connect() {
    this.validate()
  }

  validateField(event) {
    const input = event.target
    const validationType = input.dataset.validationType

    switch (validationType) {
      case "name":
        this.validateName(input)
        break
      case "email":
        this.validateEmail(input)
        break
      case "required":
        this.validateRequired(input)
        break
    }

    this.updateSubmitState()
  }

  validateName(input) {
    const value = input.value.trim()
    
    if (value.length === 0) {
      this.clearFieldState(input)
    } else if (value.length < 2) {
      this.setFieldError(input, "Name must be at least 2 characters")
    } else if (!/^[a-zA-Z\s'-]+$/.test(value)) {
      this.setFieldError(input, "Please enter a valid name")
    } else {
      this.setFieldSuccess(input)
    }
  }

  validateEmail(input) {
    const value = input.value.trim()
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/
    
    if (value.length === 0) {
      this.clearFieldState(input)
    } else if (!emailRegex.test(value)) {
      this.setFieldError(input, "Please enter a valid email")
    } else {
      this.setFieldSuccess(input)
    }
  }

  validateRequired(input) {
    const value = input.value.trim()
    
    if (value.length === 0) {
      this.setFieldError(input, "This field is required")
    } else {
      this.setFieldSuccess(input)
    }
  }

  setFieldError(input, message) {
    input.classList.remove("form-input--success")
    input.classList.add("form-input--error")
    
    this.updateFieldMessage(input, message, "error")
  }

  setFieldSuccess(input) {
    input.classList.remove("form-input--error")
    input.classList.add("form-input--success")
    
    this.removeFieldMessage(input)
  }

  clearFieldState(input) {
    input.classList.remove("form-input--error", "form-input--success")
    this.removeFieldMessage(input)
  }

  updateFieldMessage(input, message, type) {
    const wrapper = input.closest(".form-group")
    if (!wrapper) return

    let messageEl = wrapper.querySelector(".form-message")
    
    if (!messageEl) {
      messageEl = document.createElement("div")
      messageEl.className = "form-message"
      wrapper.appendChild(messageEl)
    }
    
    messageEl.className = `form-message form-${type}`
    messageEl.textContent = message
  }

  removeFieldMessage(input) {
    const wrapper = input.closest(".form-group")
    if (!wrapper) return

    const messageEl = wrapper.querySelector(".form-message")
    if (messageEl) {
      messageEl.remove()
    }
  }

  validate() {
    // Initial validation without showing errors
    this.updateSubmitState()
  }

  updateSubmitState() {
    if (!this.hasSubmitTarget) return

    const hasErrors = this.element.querySelectorAll(".form-input--error").length > 0
    const requiredInputs = this.element.querySelectorAll("[data-validation-required]")
    
    let allFilled = true
    requiredInputs.forEach(input => {
      if (!input.value.trim()) {
        allFilled = false
      }
    })

    this.submitTarget.disabled = hasErrors || !allFilled
  }
}
