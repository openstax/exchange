$(function() {
  $('.console-nav li').on('click', function() {
    $('.console-nav li').removeClass('active');
    $('.console .pane').removeClass('active');
    $(this).addClass('active');
    $('#pane-' + $(this).attr('data-pane')).addClass('active');
  })
});