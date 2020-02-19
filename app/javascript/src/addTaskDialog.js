import $ from 'jquery'

const dialog = {
  onSaveCallback: () => {},
  onCloseCallback: () => {},
  get el() {
    return $('#add-event-modal')
  },
  modal(action) {
    this.el.modal(action)
  },
  open(start, end) {
    this.el.on('hidden.bs.modal', () => this.onCloseCallback())
    const startDateTime = start.toLocal()
    const endDateTime = end.toLocal()
    this.modal()
    $('#task_datetime').datetimepicker({
      locale: 'de-ch',
      stepping: 15,
      icons: {
        time: 'far fa-clock',
      },
    })
    $('#task_datetime').datetimepicker('date', startDateTime.toJSDate())
    const duration = endDateTime.diff(startDateTime).toFormat('hh:mm')
    $('#task_duration').val(duration)
    $('#task_title')
      .val('')
      .focus()
  },
  close() {
    this.el.off('hidden.bs.modal')
    this.modal('hide')
  },
  onSave(fn) {
    this.onSaveCallback = fn
  },
  onClose(fn) {
    this.onCloseCallback = fn
  },
}

$(document).on('ajax:success', '#add-event-form', (...args) => {
  dialog.onSaveCallback(...args)
})

export default dialog
