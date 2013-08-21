function showProcessingAndPreventDefault(event){
  event.preventDefault();
  $(".message").css('display', 'inline')
}

function handleTweetResponse(response){
  $(".message").css('display', 'none');
  $('#tweet_input').prop('disabled', false);
  $('.tweet-list').html(response);
}

$(document).ready(function() {
  $('.tweet_form').on('submit', function(e) {
    var data = $(this).serialize();
    showProcessingAndPreventDefault(e)
    $('#tweet_input').prop('disabled', true);
    
    $.ajax({
      url: this.action,
      type: this.method,
      data: data
    }).done(function(response){
      handleTweetResponse(response)});
  }); 
});
