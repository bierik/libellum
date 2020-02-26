import $ from 'jquery'

export default function abstractDialog({ modalSelector, formSelector, beforeOpen = () => {}, init = () => {} } = {}) {
  const dialog = {
    onSaveCallback: () => {},
    onCloseCallback: () => {},
    onDeleteCallback: () => {},
    modal(action) {
      $(modalSelector).modal(action)
    },
    open(...args) {
      beforeOpen(...args)
      this.modal()
    },
    close() {
      this.modal('hide')
    },
    onSave(fn) {
      this.onSaveCallback = fn
    },
    onDelete(fn) {
      this.onDeleteCallback = fn
    },
    onClose(fn) {
      this.onCloseCallback = fn
    },
  }
  $(document).on('hidden.bs.modal', modalSelector, () => dialog.onCloseCallback())
  $(document).on('ajax:success', formSelector, (...args) => {
    dialog.onSaveCallback(...args)
  })
  init(dialog)

  return dialog
}
