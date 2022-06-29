import SortingTable from './sorting_table.js';
import PasswordConfirmation from "./password_confirmation.js";

document.addEventListener("turbolinks:load", function () {

  const reg_form = document.getElementById('registration')
  if (reg_form) new PasswordConfirmation(reg_form)

  const control = document.querySelector('.sort-by-title')
  const table = document.querySelector('table')
  if (control && table) control.addEventListener('click', () => new SortingTable(control, table))
})
