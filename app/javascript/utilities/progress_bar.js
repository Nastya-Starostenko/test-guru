export default class ProgressBar {
  constructor(progressBar, progressBarInfo) {
    this.progressContainer = progressBar
    this.totalQuestions = parseInt(progressBarInfo.dataset.totalQuestions)
    this.currentQuestion = parseInt(progressBarInfo.dataset.currentQuestion)
    this.showProgressBar()
  }

  showProgressBar() {
    let progressBar = document.createElement('div');
    progressBar.className = 'progress-bar'
    progressBar.role = 'progressbar'
    progressBar.ariaValueMin = 0
    progressBar.ariaValueMax = this.totalQuestions
    progressBar.ariaValueNow = this.currentQuestion
    progressBar.style.width = this.totalQuestions / this.currentQuestion * 100 + '%'
    this.progressContainer.append(progressBar)
  }
}
