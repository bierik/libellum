import $ from 'jquery'
import { DateTime } from 'luxon'

const dialog = {
  call(action) {
    $('#add-event-modal').modal(action)
  },
  open(date) {
    const datetime = DateTime.fromJSDate(date.date).set({ minute: 0, second: 0 })
    $('#task_datetime').val(datetime.toFormat("yyyy-MM-dd'T'HH:mm"))
    this.call()
  },
  close() {
    this.call('hide')
  },
  onSave(fn) {
    this.onSaveCallback = fn
  },
}

$(document).on('ajax:success', '#add-event-form', (...args) => {
  dialog.onSaveCallback(...args)
})

export default dialog
