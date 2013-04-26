# # Place all the behaviors and hooks related to the matching controller here.
# # All this logic will automatically be available in application.js.
# # You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
# renewOrgs = (count) ->
#   $('#org-counter').text(count)
# 
# gon.watch('org_count', interval: 1000, renewOrgs)

$(document).ready(() ->
  window.page_loading = () ->
    $('body').append('<div id="overlay" style="background: rgba(0, 0, 0, 0.0);">
                        <ul>
                          <li class="li1"></li>
                          <li class="li2"></li>
                          <li class="li3"></li>
                          <li class="li4"></li>
                          <li class="li5"></li>
                          <li class="li6"></li>
                        </ul>
                      </div>')
)