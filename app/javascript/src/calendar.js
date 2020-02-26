import { Calendar } from '@fullcalendar/core'
import rrulePlugin from '@fullcalendar/rrule'
import locale from '@fullcalendar/core/locales/de'
import interactionPlugin from '@fullcalendar/interaction'
import timeGridPlugin from '@fullcalendar/timegrid'
import dayGridPlugin from '@fullcalendar/daygrid'
import listPlugin from '@fullcalendar/list'
import bootstrap from '@fullcalendar/bootstrap'
import { DateTime } from 'luxon'
import api from '../src/api'
import AddTaskDialog from './addTaskDialog'
import EditTaskDialog from './editTaskDialog'

let cal

function createTask({ start, end, allDay, url }) {
  const payload = {
    start: DateTime.fromJSDate(start),
    end: DateTime.fromJSDate(end),
  }
  if (allDay) {
    payload.start = payload.start.set({ hour: 8, minute: 0 })
    payload.end = payload.start.set({ hour: 9, minute: 0 })
  }
  AddTaskDialog.open(payload)
}

async function editTask({ event: { start, end, title, url }, revert }) {
  const startDateTime = DateTime.fromJSDate(start)
  const endDateTime = DateTime.fromJSDate(end)
  const duration = endDateTime.diff(startDateTime).toFormat('hh:mm')
  const data = {
    task: {
      datetime: startDateTime.toISO(),
      duration,
      title,
    },
  }
  try {
    await api.update(url, data)
    cal.refetchEvents()
  } catch (error) {
    revert()
  }
}

const config = {
  plugins: [timeGridPlugin, rrulePlugin, interactionPlugin, listPlugin, dayGridPlugin, bootstrap],
  themeSystem: 'bootstrap',
  locale,
  defaultView: 'timeGridWeek',
  displayEventEnd: true,
  nowIndicator: true,
  weekNumbers: true,
  selectable: true,
  editable: true,
  allDaySlot: false,
  header: {
    left: 'today prev,next',
    center: 'title',
    right: 'dayGridMonth,timeGridWeek,listMonth',
  },
  select: createTask,
  eventDrop: editTask,
  eventResize: editTask,
  eventClick: ({ jsEvent, event }) => {
    jsEvent.preventDefault()
    EditTaskDialog.open(event)
  },
  defaultDate: new URLSearchParams(document.location.search).get('current-date') || DateTime.local().toISODate(),
}

function destroyCalendar() {
  if (!cal) return
  cal.destroy()
}

function initCalendar() {
  const root = document.getElementById('calendar-root')
  if (!root) return
  cal = new Calendar(root, config)
  cal.addEventSource(root.dataset.eventSource)
  window.requestAnimationFrame(() => cal.render())
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

EditTaskDialog.onSave(() => {
  if (!cal) return
  EditTaskDialog.close()
  cal.refetchEvents()
})

EditTaskDialog.onDelete(() => {
  if (!cal) return
  cal.refetchEvents()
})

document.addEventListener('turbolinks:load', initCalendar)

document.addEventListener('turbolinks:before-cache', () => {
  AddTaskDialog.close()
  EditTaskDialog.close()
  destroyCalendar()
})
