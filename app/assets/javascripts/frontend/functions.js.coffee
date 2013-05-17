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

  # truncate mission header and description
  $( '.mission_block h1' ).trunk8
    lines: 3,
    fill: '... <a class="read_more" href="#">&raquo;</a> '
  $( '.mission_description' ).trunk8
    lines: 3,
    fill: '... <a class="read_more" href="#">&raquo;</a> '
  $( ' .mission_block h1, .mission_description ').on 'click', '.read_more', ->
    $( this ).parent( ).trunk8( 'revert' ).append(' <a class="read_less" href="#">&laquo;</a>' )
  $( ' .mission_block h1 ').on 'click', '.read_less', ->
    $( this ).parent( ).trunk8( { lines: 3 } )
  $( ' .mission_description ').on 'click', '.read_less', ->
    $( this ).parent( ).trunk8( { lines: 3 } )

  # hide or show carousel controls if there are or not more elements to show by side
  $( '.carousel' ).carousel( interval: false ) # disable autocycling in carousel
  $( '.carousel-control.right' ).click ->
    $( this ).prev( ).removeClass( 'hidden' )
    if( !$( this ).prev( ).prev( '.carousel-inner' ).children( '.item:last' ).hasClass( 'active' ) )
      $( this ).addClass( 'hidden' )
    event.stopPropagation
  $( '.carousel-control.left' ).click ->
    $( this ).next( ).removeClass( 'hidden' )
    if( !$( this ).prev( ).prev( '.carousel-inner' ).children( '.item:first' ).hasClass( 'active' ) )
      $( this ).addClass( 'hidden' )
    event.stopPropagation