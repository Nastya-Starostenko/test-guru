import FormInline from "./form_inline";

export default class DisableElements {
  constructor(elementsForDisable, activeElement) {
    this.elementStayActive = activeElement
    this.elemetsForAction = [...elementsForDisable].filter(item => item != this.elementStayActive )
    this.setup()
  }

  setup() {
    this.enable_inputs();
    this.disable_inputs();
  }

  disable_inputs() {
    this.elemetsForAction.forEach(input => {
      input.disabled = true;
      input.value = '';
      input.checked = false;
    })
  }

  enable_inputs() {
    document.querySelectorAll('input, select').forEach(input => {
        input.disabled = false;
    })
  }
}
