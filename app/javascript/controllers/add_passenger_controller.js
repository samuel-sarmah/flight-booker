import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
    static targets = ["container", "template"]
    static values = { count: Number}

    connect() {
        // Initialize count based on existing passenger count
        this.countValue = this.containerTarget.querySelectorAll("fieldset").length
    }

    add(event) {
        event.preventDefault()

        // Increment passenger count
        this.countValue++;

        // Clone the template
        const template = this.templateTarget.content.cloneNode(true)
        const fieldset = template.querySelector("fieldset")

        // Update the legend with new passenger number
        const legend = fieldset.querySelector("legend")
        legend.textContent = `Passenger ${this.countValue}`

        // Update field names and IDs to use correct index
        const inputs = fieldset.querySelectorAll("input")
        inputs.forEach(input => {
            const name = input.getAttribute("name");
            const id = input.getAttribute("id")

            if (name) {
                input.setAttribute("name", name.replace(/\[\d+\]/, `[${this.countValue - 1}]`))
            }
            if (id) {
                input.setAttribute("id", id.replace(/_\d+/, `_${this.countValue -  1}_`))
            }
        });

        // Append to container
        this.containerTarget.appendChild(fieldset)
    }
}