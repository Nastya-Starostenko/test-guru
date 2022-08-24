export default class Timer {
  constructor(control, intervalId) {
    this.control = control;
    this.now = new Date().getTime();
    this.endTime = Date.parse(control.dataset.endTime.replace(/"/g, ''));
    this.distance = this.endTime - this.now;
    this.intervalId = intervalId;
    this.startTimer()
  }

  startTimer() {
    let minutes = Math.floor((this.distance % (1000 * 60 * 60)) / (1000 * 60));
    let seconds = Math.floor((this.distance % (1000 * 60)) / 1000);

    if (this.distance <= 0) {
      clearInterval(this.intervalId);
      const form = document.querySelector('form');
      form.submit();
    }

    this.control.innerHTML = " " + minutes + " : " + seconds;
  }
}
