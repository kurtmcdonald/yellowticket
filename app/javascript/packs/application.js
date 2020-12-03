// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)


// ----------------------------------------------------
// Note(lewagon): ABOVE IS RAILS DEFAULT CONFIGURATION
// WRITE YOUR OWN JS STARTING FROM HERE 👇
// ----------------------------------------------------

// External imports
import $ from "jquery";
import "bootstrap";
import { initMapbox } from '../plugins/init_mapbox';

import { find_status, hideActiveOrder } from '../plugins/confirmation_page';
import { toggleSpinner} from './spinner';
import { edit_item } from '../plugins/edit_item';

import { initAutocomplete } from '../plugins/init_autocomplete';

window.$ = $
global.$ = $

document.addEventListener('turbolinks:load', () => {
  edit_item();
  initMapbox();
  initAutocomplete();
  find_status();
  hideActiveOrder();
  toggleSpinner();
})

//sweet alert
import { initSweetalert } from '../plugins/init_sweetalert';

initSweetalert('#sweet-alert-demo', {
  title: "A nice alert",
  text: "This is a great alert, isn't it?",
  icon: "success"
});
