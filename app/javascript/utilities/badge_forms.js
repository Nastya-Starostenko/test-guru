import DisableElements from "./disable_elements";

export default class BadgeForms {
  constructor(conditions) {
    this.conditions = conditions;
  }

  setElementsForDisable(badgeTypes) {
    this.typeTest = badgeTypes.querySelector('.form-check-input-test')
    this.typeCategory = badgeTypes.querySelector('.form-check-input-category')
    this.typeLevel = badgeTypes.querySelector('.form-check-input-level')
    this.typeLevelAndCategory = badgeTypes.querySelector('.form-check-input-level_and_category')
    this.test = this.conditions.querySelectorAll('.test-field')
    this.allExceptTest = [...this.conditions.querySelectorAll('input, select')].filter(item => item != this.test[0])
    this.allExceptCategory = this.conditions.querySelectorAll('.test-field, .level-field')
    this.allExceptLevel = this.conditions.querySelectorAll('.test-field, .category-field')

    this.enableTypeOftest()
    this.addListeners()
  }

  enableTypeOftest() {
    [this.typeTest, this.typeCategory, this.typeLevel, this.typeLevelAndCategory].forEach(item => {
      item.disabled = false;
    })
  }

  addListeners() {
    this.listenerForDisableElement(this.typeTest, this.allExceptTest)
    this.listenerForDisableElement(this.typeCategory, this.allExceptCategory)
    this.listenerForDisableElement(this.typeLevel, this.allExceptLevel)
    this.listenerForDisableElement(this.typeLevelAndCategory, this.test)
  }

  listenerForDisableElement(item, elemntsForDisable) {
    item.addEventListener('change', () =>
      new DisableElements(elemntsForDisable))
    if (item.checked) {
      item.dispatchEvent(new Event("change"));
    }
  }


  updateRadioCount() {
    const countOfTestBlock = this.conditions.querySelector('.count_of_test')
    const allRadio = countOfTestBlock.querySelectorAll('input[type=radio]')
    const input = this.conditions.querySelector('#count_of_test')
    const radio = this.conditions.querySelector('#badge_count_of_test_count')

    allRadio.forEach(item =>
      item.addEventListener('change', function (e) {
        allRadio.forEach(item => item.checked = false)
        input.value = '';
        item.checked = true
      })
    )

    input.addEventListener('change', function (e) {
      allRadio.forEach(item => item.checked = false)
      e.target.value ? radio.checked = true : radio.checked = false
    })
  }
}
