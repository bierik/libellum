# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@fullcalendar/core", to: "https://www.unpkg.com/fullcalendar@5.11.3/main.min.js"
pin "@fullcalendar/locales", to: "https://ga.jspm.io/npm:@fullcalendar/core@5.11.3/locales-all.js"
pin "@fullcalendar/common", to: "https://ga.jspm.io/npm:@fullcalendar/common@5.11.3/main.js"
pin "preact", to: "https://ga.jspm.io/npm:preact@10.10.6/dist/preact.module.js"
pin "preact/compat", to: "https://ga.jspm.io/npm:preact@10.10.6/compat/dist/compat.module.js"
pin "preact/hooks", to: "https://ga.jspm.io/npm:preact@10.10.6/hooks/dist/hooks.module.js"
pin "tslib", to: "https://ga.jspm.io/npm:tslib@2.4.0/tslib.es6.js"
pin "@fullcalendar/bootstrap", to: "https://ga.jspm.io/npm:@fullcalendar/bootstrap@5.11.3/main.js"
pin "luxon", to: "https://ga.jspm.io/npm:luxon@3.0.3/src/luxon.js"
pin "bootstrap", to: "https://ga.jspm.io/npm:bootstrap@5.2.0/dist/js/bootstrap.esm.js"
pin "@popperjs/core", to: "https://unpkg.com/@popperjs/core@2.11.6/dist/esm/index.js"
pin "@fullcalendar/rrule", to: "https://ga.jspm.io/npm:@fullcalendar/rrule@5.11.3/main.js"
pin "rrule", to: "https://ga.jspm.io/npm:rrule@2.7.1/dist/esm/index.js"
pin "@fullcalendar/daygrid", to: "https://ga.jspm.io/npm:@fullcalendar/daygrid@5.11.3/main.js"
pin "@fullcalendar/list", to: "https://ga.jspm.io/npm:@fullcalendar/list@5.11.3/main.js"
pin "@fullcalendar/timegrid", to: "https://ga.jspm.io/npm:@fullcalendar/timegrid@5.11.3/main.js"
pin "@fullcalendar/interaction", to: "https://ga.jspm.io/npm:@fullcalendar/interaction@5.11.3/main.js"
pin "jquery", to: "https://ga.jspm.io/npm:jquery@3.6.0/dist/jquery.js"
pin "@rails/ujs", to: "https://ga.jspm.io/npm:@rails/ujs@7.0.3-1/lib/assets/compiled/rails-ujs.js"
