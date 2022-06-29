export default class SortingTable {
  constructor(control, table) {
    this.table = table
    this.arrowUp = control.querySelector('.octicon-arrow-up')
    this.arrowDown = control.querySelector('.octicon-arrow-down')
    this.sorted_rows = Array.from(table.rows).slice(1)

    this.setup()
  }

  setup() {
    if (this.arrowUp.classList.contains('hide')) {
      this.sortRowAsc()
      this.arrowUp.classList.remove('hide')
      this.arrowDown.classList.add('hide')
    } else {
      this.sortRowDesc()
      this.arrowDown.classList.remove('hide')
      this.arrowUp.classList.add('hide')
    }
    this.append_new_table();
  }

  sortRowAsc() {
    this.sorted_rows.sort((firstItem, secondItem) => firstItem.cells[0].innerText > secondItem.cells[0].innerText ? 1 : -1)
  }

  sortRowDesc() {
    this.sorted_rows.sort((firstItem, secondItem) => firstItem.cells[0].innerText > secondItem.cells[0].innerText ? -1 : 1)
  }

  append_new_table() {
    this.table.tBodies[0].append(...this.sorted_rows)
  }
}
