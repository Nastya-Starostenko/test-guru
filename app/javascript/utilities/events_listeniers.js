import SortingTable from './sorting_table.js';
import PasswordConfirmation from "./password_confirmation.js";
import FormInline from "./form_inline.js";
import ProgressBar from "./progress_bar.js";

document.addEventListener("turbolinks:load", function () {

  const reg_form = document.getElementById('registration')
  if (reg_form) new PasswordConfirmation(reg_form)

  const control = document.querySelector('.sort-by-title')
  const table = document.querySelector('table')
  if (control && table) control.addEventListener('click', () => new SortingTable(control, table))


  document.querySelectorAll('.form-inline-link').forEach(form => {
    form.addEventListener('click', event => {
      event.preventDefault()
      new FormInline(form)
    })
  })

  let errors = document.querySelector('.resource-errors')
  if (errors) {
    let formInline = document.querySelector('.form-inline[data-test-id="' + errors.dataset.resourceId + '"]')
    if (formInline) new FormInline(formInline)
  }

  const progressBarInfo = document.querySelector('.progress-bar-info')
  const progressBar = document.querySelector('.progress')
  if (progressBar && progressBarInfo) {
    new ProgressBar(progressBar, progressBarInfo)
  }

  let change_location_button = document.querySelector('.change_location')
  if (change_location_button) {
    change_location_button.addEventListener('click', event => {
      event.preventDefault()
      let lang = '?lang=ru'
      location.search = location.search.includes(lang) ? '' : lang;
    })
  }
})


