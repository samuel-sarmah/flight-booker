import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
    static targets = ["container", "template"]

    add(event) {
        event.preventDefault()

        // Count the current passengers instead of using a stored value
        const currentCount = this.containerTarget.querySelectorAll("fieldset").length;
        const newIndex = currentCount;

        // Clone the template
        const template = this.templateTarget.content.cloneNode(true)
        const fieldset = template.querySelector("fieldset")

        // Update the legend with new passenger number
        const legend = fieldset.querySelector("legend")
        legend.textContent = `Passenger ${currentCount + 1}`

        // Update field names and IDs to use correct index
        const inputs = fieldset.querySelectorAll("input")
        inputs.forEach(input => {
            const name = input.getAttribute("name");
            const id = input.getAttribute("id")

            if (name) {
                input.setAttribute("name", name.replace(/\[\d+\]/, `[${newIndex}]`))
            }
            if (id) {
                input.setAttribute("id", id.replace(/_\d+/, `_${newIndex}_`))
            }
        });

        // Update the labels
        const labels = fieldset.querySelectorAll("label");
        labels.forEach(label => {
            const forAttr = label.getAttribute("for")
            if (forAttr) {
                label.setAttribute("for", forAttr.replace(/_\d+/, `_${newIndex}_`))
            }
        })

        // Append to container
        this.containerTarget.appendChild(fieldset)
    }
}