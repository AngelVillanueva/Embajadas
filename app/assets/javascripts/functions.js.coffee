$(document).ready ->
  # debug slider (not for production)
  if ($('#debug').size())
    $('#debug').hide()
    $('a.debug').click ->
      $('#debug').slideToggle()
      $('a.debug b').toggleClass('clicked')
      event.stopPropagation()
  # Get rid of facebook api url appending bug
  if window.location.hash == '#_=_'
    window.location.hash = ''
  # init tooltips
  $('a[rel*="tooltip"]').tooltip({ 'placement': 'bottom' })
  $('i[rel="tooltip"]').tooltip()
  # instructions panel
  $( '.instructions_toggle_button, .instructions_mini_toggle' ).click ->
      $( 'body' ).toggleClass( 'instructions_open' )