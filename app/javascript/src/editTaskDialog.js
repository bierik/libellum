import $ from 'jquery'
import abstractDialog from './abstractDialog'

export default abstractDialog({
  modalSelector: '#edit-event-modal',
  formSelector: '#edit-event-form',
  beforeOpen: ({ title, url }) => {
    $('#task_edit_title').val(title)
    $('#edit-event-form').attr('action', url)
    $('#task_delete_button').attr('href', url)
  },
  init: ({ onDeleteCallback }) => {
    $(document).on('click', '#task_delete_button', () => onDeleteCallback())
  },
})
