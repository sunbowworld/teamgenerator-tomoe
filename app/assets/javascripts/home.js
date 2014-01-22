// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(function(){
  var tg_users = new Array()
  $('.steam_card').click(function(){
    switch($(this).parent().attr('class')){
      case 'user_list':
        $(this).appendTo('.tg_user')
        break
      case 'tg_user':
        $(this).appendTo('.user_list')
        break
      default:
        $(this).appendTo('.user_list')
        break
    }
  })
  $('.generator').click(function(){
  })
})