// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "./controllers"
import * as bootstrap from "bootstrap"
import $ from '../../vendor/javascript/jquery';
window.$ = $;
window.jQuery = $;

$(document).on('turbo:load', function() {
  $('.js-tweet-action').on('click', function () {
    $(this).next().fadeToggle();
  });
})
