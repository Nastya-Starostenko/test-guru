import FormInline from "./form_inline";

export default class DisableElements {
  constructor(current_element, groupForDisable) {
    this.current_element = current_element
    this.groupForDisable = groupForDisable
    this.elemetsForAction = [...this.groupForDisable.querySelectorAll('input'),
      ...this.groupForDisable.querySelectorAll('select')].filter((value, index, arr) => {
      return value != this.current_element;
    });
    this.setup()
  }

  setup() {
    if (this.current_element.type === 'checkbox') {
      !!this.current_element.checked ? this.disable_inputs() : this.enable_inputs()
    }
    else {
      !!this.current_element.value ? this.disable_inputs() : this.enable_inputs()
    }
  }

  disable_inputs() {
    this.elemetsForAction.forEach(input => {
      input.disabled = true;
      input.value = '';
    })
  }

  enable_inputs() {
    this.elemetsForAction.forEach(input => {
        input.disabled = false;

    })
  }
}
