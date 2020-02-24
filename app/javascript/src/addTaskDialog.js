import $ from 'jquery'
import abstractDialog from './abstractDialog'

export default abstractDialog({
  modalSelector: '#add-event-modal',
  formSelector: '#add-event-form',
  beforeOpen: ({ start, end }) => {
    const startDateTime = start.toLocal()
    const endDateTime = end.toLocal()
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
})
