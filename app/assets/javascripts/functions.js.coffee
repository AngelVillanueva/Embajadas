$(document).ready ->
  # Get rid of facebook api url appending bug
  if window.location.hash == '#_=_'
    window.location.hash = ''
  # init tooltips
  $('a[rel="tooltip"]').tooltip({ 'placement': 'bottom' })