// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
import 'bootstrap/dist/css/bootstrap.css'
import '@fortawesome/fontawesome-free/js/fontawesome'
import '@fortawesome/fontawesome-free/js/solid'
import '@fortawesome/fontawesome-free/js/regular'
import '@fortawesome/fontawesome-free/js/brands'
import '@fullcalendar/core/main.css'
import '@fullcalendar/timegrid/main.css'
import '@fullcalendar/list/main.css'
import '@fullcalendar/daygrid/main.css'
import '@fullcalendar/bootstrap/main.css'
import 'tempusdominus-bootstrap-4/build/css/tempusdominus-bootstrap-4.css'
import '../../assets/stylesheets/calendar'
import '../../assets/stylesheets/modal'
import '../../../vendor/assets/purpose/css/purpose'

import 'jquery'
import '@popperjs/core'
import 'bootstrap'
import 'tempusdominus-bootstrap-4'
import '../src/calendar'
import '../../../vendor/assets/purpose/js/purpose'
import { Settings } from 'luxon'

Settings.defaultLocale = 'de-CH'

require('@rails/ujs').start()
require('turbolinks').start()
require('@rails/activestorage').start()
require('channels')

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
require.context('../../../vendor/assets/purpose/img/svg', true)
// const imagePath = (name) => images(name, true)
