import DisableElements from "./disable_elements";

document.addEventListener("turbolinks:load", function () {
  let conditions = document.querySelector('.conditions')

  if (conditions && !window.location.href.includes('edit')) {
    let typeTest = document.querySelector('.form-check-input-test')
    let typeCategory = document.querySelector('.form-check-input-category')
    let typeLevel = document.querySelector('.form-check-input-level')
    let typeLevelAndCategory = document.querySelector('.form-check-input-level_and_category')

    let allInputs = conditions.querySelectorAll('input, select')
    let test = conditions.querySelectorAll('.test-field')
    let allExceptCategory = conditions.querySelectorAll('.test-field, .level-field')
    let allExceptLevel = conditions.querySelectorAll('.test-field, .category-field')


    let arrayForEvents = [{ forEvent: typeTest, active: test[0], disable: allInputs},
      { forEvent: typeCategory, active: null, disable: allExceptCategory },
      { forEvent: typeLevel, active: null , disable: allExceptLevel },
      { forEvent: typeLevelAndCategory, active: null, disable: test }]

    arrayForEvents.forEach(item => {
      item['forEvent'].disabled = false;
      if (item['forEvent']) item['forEvent'].addEventListener('change', () =>
        new DisableElements( item['disable'], item['active']))

      if (item['forEvent'].checked) {
        item['forEvent'].dispatchEvent(new Event("change"));
      }
    })



    let countOfTestBlock = document.querySelector('.count_of_test')
    if (countOfTestBlock) countOfTestBlock.querySelectorAll('input[type=radio]').forEach(item =>
      item.addEventListener('change', function (e) {
        let input = conditions.querySelector('#count_of_test')
        input.value = ''
      }))

    let countOfTestInput = document.querySelector('#count_of_test')
    if (countOfTestInput) countOfTestInput.addEventListener('change', function (e) {
      let radio = conditions.querySelector('#badge_count_of_test_count')
      e.target.value ? radio.checked = true : radio.checked = false
    })
  }
})