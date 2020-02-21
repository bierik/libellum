import { Calendar } from '@fullcalendar/core'
import rrulePlugin from '@fullcalendar/rrule'
import locale from '@fullcalendar/core/locales/de'
import interactionPlugin from '@fullcalendar/interaction'
import timeGridPlugin from '@fullcalendar/timegrid'
import dayGridPlugin from '@fullcalendar/daygrid'
import listPlugin from '@fullcalendar/list'
import bootstrap from '@fullcalendar/bootstrap'
import { DateTime } from 'luxon'
import AddTaskDialog from './addTaskDialog'

const config = {
  plugins: [timeGridPlugin, rrulePlugin, interactionPlugin, listPlugin, dayGridPlugin, bootstrap],
  themeSystem: 'bootstrap',
  locale,
  defaultView: 'timeGridWeek',
  displayEventEnd: true,
  nowIndicator: true,
  weekNumbers: true,
  selectable: true,
  allDaySlot: false,
  header: {
    left: 'today prev,next',
    center: 'title',
    right: 'dayGridMonth,timeGridWeek,listMonth',
  },
  select: ({ start, end, allDay }) => {
    const startDateTime = DateTime.fromJSDate(start)
    const endDateTime = DateTime.fromJSDate(end)
    if (allDay) {
      AddTaskDialog.open(startDateTime.set({ hour: 8, minute: 0 }), startDateTime.set({ hour: 9, minute: 0 }))
    } else {
      AddTaskDialog.open(startDateTime, endDateTime)
    }
  },
  defaultDate: new URLSearchParams(document.location.search).get('current-date') || DateTime.local().toISODate(),
}

let cal

function destroyCalendar() {
  if (!cal) return
  cal.destroy()
}

function initCalendar() {
  const root = document.getElementById('calendar-root')
  if (!root) return
  cal = new Calendar(root, config)
  cal.addEventSource(root.dataset.eventSource)
  cal.render()
}

AddTaskDialog.onSave(() => {
  if (!cal) return
  cal.refetchEvents()
  AddTaskDialog.close()
})

AddTaskDialog.onClose(() => {
  if (!cal) return
  cal.unselect()
})

document.addEventListener('turbolinks:load', initCalendar)

document.addEventListener('turbolinks:before-cache', () => {
  AddTaskDialog.close()
  destroyCalendar()
})
