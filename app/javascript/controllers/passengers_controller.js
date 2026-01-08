import { Controller } from "@hotwired/stimulus"

// Handles adding passengers dynamically with animation
export default class extends Controller {
  static targets = ["container", "template", "count", "addBtn"]
  static values = { max: { type: Number, default: 9 } }

  connect() {
    this.updateUI()
  }

  add(event) {
    event.preventDefault()

    const count = this.containerTarget.querySelectorAll(".passenger-card").length

    if (count >= this.maxValue) {
      return
    }

    const template = this.templateTarget.content.cloneNode(true)
    const card = template.querySelector(".passenger-card")

    // Update the passenger number
    const title = card.querySelector(".passenger-card__title")
    if (title) {
      title.textContent = `Passenger ${count + 1}`
    }

    // Update field names with correct index
    const inputs = card.querySelectorAll("input")
    inputs.forEach(input => {
      const name = input.getAttribute("name")
      const id = input.getAttribute("id")
      if (name) {
        input.setAttribute("name", name.replace(/\[\d+\]/, `[${count}]`))
      }
      if (id) {
        input.setAttribute("id", id.replace(/_\d+_/, `_${count}_`))
      }
    })

    const labels = card.querySelectorAll("label")
    labels.forEach(label => {
      const forAttr = label.getAttribute("for")
      if (forAttr) {
        label.setAttribute("for", forAttr.replace(/_\d+_/, `_${count}_`))
      }
    })

    // Add with animation
    card.style.opacity = "0"
    card.style.transform = "translateY(20px)"
    this.containerTarget.appendChild(card)

    requestAnimationFrame(() => {
      card.style.transition = "all 0.3s ease-out"
      card.style.opacity = "1"
      card.style.transform = "translateY(0)"
    })

    // Focus the first input
    setTimeout(() => {
      const firstInput = card.querySelector("input")
      if (firstInput) {
        firstInput.focus()
      }
    }, 100)

    this.updateUI()
  }

  remove(event) {
    event.preventDefault()
    const card = event.target.closest(".passenger-card")
    
    if (card) {
      // Animate out
      card.style.transition = "all 0.2s ease-out"
      card.style.opacity = "0"
      card.style.transform = "translateY(-10px)"
      
      setTimeout(() => {
        card.remove()
        this.renumberPassengers()
        this.updateUI()
      }, 200)
    }
  }

  renumberPassengers() {
    const cards = this.containerTarget.querySelectorAll(".passenger-card")
    cards.forEach((card, index) => {
      const title = card.querySelector(".passenger-card__title")
      if (title) {
        title.textContent = `Passenger ${index + 1}`
      }

      // Update input names
      const inputs = card.querySelectorAll("input")
      inputs.forEach(input => {
        const name = input.getAttribute("name")
        const id = input.getAttribute("id")
        if (name) {
          input.setAttribute("name", name.replace(/\[\d+\]/, `[${index}]`))
        }
        if (id) {
          input.setAttribute("id", id.replace(/_\d+_/, `_${index}_`))
        }
      })

      const labels = card.querySelectorAll("label")
      labels.forEach(label => {
        const forAttr = label.getAttribute("for")
        if (forAttr) {
          label.setAttribute("for", forAttr.replace(/_\d+_/, `_${index}_`))
        }
      })
    })
  }

  updateUI() {
    const count = this.containerTarget.querySelectorAll(".passenger-card").length
    
    if (this.hasCountTarget) {
      this.countTarget.textContent = count
    }

    if (this.hasAddBtnTarget) {
      this.addBtnTarget.disabled = count >= this.maxValue
    }

    // Show/hide remove buttons based on count
    const removeButtons = this.containerTarget.querySelectorAll("[data-action*='passengers#remove']")
    removeButtons.forEach(btn => {
      btn.style.display = count > 1 ? "inline-flex" : "none"
    })
  }
}
