
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener('DOMContentLoaded', function() {
    const startDateField = document.querySelector('#start_date');
    const endDateField = document.querySelector('#end_date');
  
    if (startDateField && endDateField) {
      startDateField.addEventListener('change', function() {
        endDateField.min = startDateField.value;
      });
    }
  });
