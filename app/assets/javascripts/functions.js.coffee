et_duplicate_menu = ( menu, append_to, menu_id, menu_class ) ->
  menu.clone().attr('id',menu_id).removeClass().attr('class',menu_class).appendTo( append_to );
  $cloned_nav = append_to.find('> ul');
  $cloned_nav.find('.menu_slide').remove();
  $cloned_nav.find('li:first').addClass('et_first_mobile_item');
  append_to.click ->
    if ( $(this).hasClass('closed') )
      $(this).removeClass( 'closed' ).addClass( 'opened' );
      $cloned_nav.slideDown( 500 );
    else
      $(this).removeClass( 'opened' ).addClass( 'closed' );
      $cloned_nav.slideUp( 500 );
    return false;
  append_to.find('a').click ->
    event.stopPropagation();

$(document).ready ->
  # debug slider (not for production)
  if ($('#debug').size())
    $('#debug').hide()
    $('a.debug').click ->
      $('#debug').slideToggle()
      event.stopPropagation()
  # duplicate and activate menu for mobile in frontend
  et_duplicate_menu( $('ul.nav'), $('#main-header .mobile_nav'), 'mobile_menu', 'et_mobile_menu' );
  # Get rid of facebook api url appending bug
  if window.location.hash == '#_=_'
    window.location.hash = ''
  # init tooltips
  $('a[rel="tooltip"]').tooltip({ 'placement': 'bottom' })