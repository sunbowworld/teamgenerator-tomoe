// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(function(){
  $('.steam_card').click(function(){
    switchClassParent($(this),'.user_list','.tg_area')
  })
  $('.generator').click(function(){
    var users = $('.tg_user').children('.steam_card')
  })
  $('.teams_value').click(function(){
    $('.number_of_teams > .value').text($(this).text())
  })
  $('.users_value').click(function(){
    $('.number_of_users > .value').text($(this).text())
  })
})