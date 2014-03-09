// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(function(){
  $('.steam_card').click(function(){
    switchClassParent($(this),'.user_list','.register_users')
  })
  $('#submit').click(function(){
    $('.register_users').children('.steam_card').each(function(){
      $('#form').append($('<input/>', {type: 'hidden', name: 'staem_id64s[]', value: $(this).attr('id')}))
    })
    $('#form').submit()
  })
})