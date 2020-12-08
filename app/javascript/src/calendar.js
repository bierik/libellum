import { Calendar } from '@fullcalendar/core'
import rrulePlugin from '@fullcalendar/rrule'
import locale from '@fullcalendar/core/locales/de'
import interactionPlugin from '@fullcalendar/interaction'
import timeGridPlugin from '@fullcalendar/timegrid'
import dayGridPlugin from '@fullcalendar/daygrid'
import listPlugin from '@fullcalendar/list'
import bootstrap from '@fullcalendar/bootstrap'
import { DateTime } from 'luxon'
import $ from 'jquery'
import api from '../src/api'
import AddTaskDialog from './addTaskDialog'
import EditTaskDialog from './editTaskDialog'

// https://github.com/fullcalendar/fullcalendar/issues/5544
window.FontAwesome.config.autoReplaceSvg = 'nest'

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

function createConfig(eventRender = () => {}) {
  return {
    plugins: [timeGridPlugin, rrulePlugin, interactionPlugin, listPlugin, dayGridPlugin, bootstrap],
    themeSystem: 'bootstrap',
    locale,
    displayEventEnd: true,
    nowIndicator: true,
    weekNumbers: true,
    selectable: true,
    editable: true,
    allDaySlot: false,
    height: 'auto',
    slotMinTime: '06:00:00',
    slotMaxTime: '20:00:00',
    headerToolbar: {
      left: 'prev,next today',
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
    initialDate: new URLSearchParams(document.location.search).get('current-date') || DateTime.local().toISODate(),
    slotDuration: '00:15:00',
    scrollTime: '08:00:00',
    businessHours: {
      // days of week. an array of zero-based day of week integers (0=Sunday)
      daysOfWeek: [1, 2, 3, 4, 5], // Monday - Friday
      startTime: '08:00',
      endTime: '18:00',
    },
    initialView:
      localStorage.getItem('fcDefaultView') !== null ? localStorage.getItem('fcDefaultView') : 'timeGridWeek',
    datesSet({ view }) {
      localStorage.setItem('fcDefaultView', view.type)
    },
    eventDidMount: eventRender,
  }
}

function destroyCalendar() {
  if (!cal) return
  cal.destroy()
}

function initCalendar(selector, eventRender) {
  const root = document.getElementById(selector)
  if (!root) return
  cal = new Calendar(root, createConfig(eventRender))
  cal.addEventSource({ url: root.dataset.eventSource })
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

EditTaskDialog.onSave(() => {
  if (!cal) return
  EditTaskDialog.close()
  cal.refetchEvents()
})

EditTaskDialog.onDelete(() => {
  if (!cal) return
  cal.refetchEvents()
})

document.addEventListener('turbolinks:load', () => initCalendar('calendar-customer-root'))
document.addEventListener('turbolinks:load', () =>
  initCalendar(
    'calendar-dashboard-root',
    ({
      event: {
        extendedProps: { customer, brightColor },
      },
      el,
      view: { type },
    }) => {
      const customerEl = $('<em>').addClass('small d-block').text(customer)
      if (type !== 'listMonth') {
        if (brightColor) {
          $(el).addClass('text-dark')
        }
      }
      if (type === 'timeGridWeek') {
        $('.fc-event-title-container', el).append(customerEl)
      } else if (type === 'listMonth') {
        $('.fc-list-event-title', el).append(customerEl)
      }
    },
  ),
)

document.addEventListener('turbolinks:before-cache', () => {
  AddTaskDialog.close()
  EditTaskDialog.close()
  destroyCalendar()
})
