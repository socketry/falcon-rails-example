# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"

pin "morphdom", to: "https://ga.jspm.io/npm:morphdom@2.7.1/dist/morphdom-esm.js"
pin "@socketry/live", to: "https://ga.jspm.io/npm:@socketry/live@0.6.0/Live.js"
