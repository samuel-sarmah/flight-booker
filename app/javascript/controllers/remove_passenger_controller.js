import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
    static targets = ["container"];

    remove(event) {
        event.preventDefault();

        // Get the fieldset to remove
        const fieldset = event.target.closest("fieldset")

        // Don't allow removeing if only one passenger remains
        const fieldsets = this.containerTarget.querySelectorAll("fieldset");
        if (fieldsets.length <= 1) {
            alert("At least one passenger is required")
            return;
        }

        // Remove the fieldset
        fieldset.remove();

        // Reindex all remaining fieldsets
        this.reindexPassengers();
    }

    reindexPassengers() {
        const fieldsets  =  this.containerTarget.querySelectorAll("fieldset");

        fieldsets.forEach((fieldset, index) => {
            // Update the legend
            const legend = fieldset.querySelector("legend")
            if (legend) {
                legend.textContent = `Passenger ${index + 1}`
            }

            // Update all input fields
            const inputs = fieldset.querySelectorAll("input");
            inputs.forEach(input => {
                const name = input.getAttribute("name");
                const id = input.getAttribute("id")

                if (name) {
                    // Replace the index in name: booking[passengers_attributes][X][field]
                    input.setAttribute("name", name.replace(/\[passengers_attributes\]\[\d+\]/, `[passengers_attributes][${index}]`))
                }

                if (id) {
                    // Replace the index in id: booking_passengers_attributes_X_field
                    input.setAttribute("id", id.replace(/passengers_attributes_\d+_/, `passengers_attributes_${index}_`));
                }
            })

            // Update labels
            const labels = fieldset.querySelectorAll("label")
            labels.forEach(label => {
                const forAttr = label.getAttribute("for")
                if (forAttr) {
                    label.setAttribute("for", forAttr.replace(/passengers_attributes_\d+_/, `passengers_attributes_${index}_`))
                }
            })
        })
    }
}