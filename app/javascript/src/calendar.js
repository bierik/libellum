import { Calendar } from '@fullcalendar/core'
import rrulePlugin from '@fullcalendar/rrule'
import locale from '@fullcalendar/core/locales/de'
import interactionPlugin from '@fullcalendar/interaction'
import timeGridPlugin from '@fullcalendar/timegrid'
import dayGridPlugin from '@fullcalendar/daygrid'
import listPlugin from '@fullcalendar/list'
import { DateTime } from 'luxon'
import AddTaskDialog from './addTaskDialog'

const config = {
  plugins: [timeGridPlugin, rrulePlugin, interactionPlugin, listPlugin, dayGridPlugin],
  locale,
  defaultView: 'timeGridWeek',
  displayEventEnd: true,
  nowIndicator: true,
  weekNumbers: true,
  header: {
    left: 'title',
    center: 'dayGridMonth,timeGridWeek,listMonth',
    right: 'today prev,next',
  },
  dateClick: (date) => AddTaskDialog.open(date),
  defaultDate: new URLSearchParams(document.location.search).get('current-date') || DateTime.local().toISODate(),
}

Calendar.prototype.root = null

Calendar.prototype.isLoaded = function isLoaded() {
  return this.root && this.root.classList.contains('rc')
}

Calendar.prototype.attachEventSource = function attachEventSource() {
  this.addEventSource(this.root.dataset.eventSource)
}

function initCalendar() {
  const root = document.getElementById('calendar-root')
  if (!root) return
  Calendar.prototype.root = root
  if (Calendar.prototype.isLoaded()) return
  const cal = new Calendar(Calendar.prototype.root, config)
  cal.attachEventSource()
  cal.render()
  return cal
}

let cal

document.addEventListener('turbolinks:load', () => {
  cal = initCalendar()
})

AddTaskDialog.onSave(() => {
  if (!cal) return
  cal.refetchEvents()
  AddTaskDialog.close()
})
