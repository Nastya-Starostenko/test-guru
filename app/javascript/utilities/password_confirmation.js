export default class PasswordConfirmation {
  constructor(form) {
    this.form = form
    this.password = form.elements.password
    this.password_confirmation = form.elements.password_confirmation
    this.submit_button = form.elements.signup

    this.setup()
  }

  resetStyleForInputs() {
    this.password_confirmation.classList.remove('is-invalid')
    this.password_confirmation.classList.remove('is-valid')
  }

  checkPasswords() {
    if (this.password_confirmation.value == this.password.value) {
      this.password_confirmation.classList.add('is-valid')
    } else {
      this.password_confirmation.classList.add('is-invalid')
    }
  }

  updateDisableSubmit() {
    if (this.password_confirmation.classList.contains('is-valid')) {
      this.submit_button.classList.remove('disabled')
    } else {
      this.submit_button.classList.add('disabled')
    }
  }

  setup() {
    this.form.addEventListener('keyup', event => {
      this.resetStyleForInputs()
      if (this.password_confirmation.value) this.checkPasswords()
      this.updateDisableSubmit()
    })
  }
}
