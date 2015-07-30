$(document).ready(function() {
    $('[data-toggle="popover"]').popover();
});
$(".rating").rating();

$(document).on('click', '.category_id a', function() {
    var cat_id = $(this).data('id');
    $('.category_name').text($(this).data('title'));
    $.ajax({
        type: "GET",
        data: {category_id: cat_id},
        dataType: "html",
        url: "/books",
        success: function(response) {
            $('.all_books').html(response);
        }
    });
});
$(document).on('rating.change', function(event, value) {
    $.ajax({
        type: "POST",
        data: { rating_number: value, book_id: $('#rating_star_book').attr('data-book-id'), user_id: $('#rating_star_book').attr('data-user-id') },
        dataType: "json",
        url: "/ratings"
    });
});
$(document).on('submit', '.rating_form', function(event) {
    if($('textarea#review').val().length == 0) {
        event.preventDefault();
        alert('Write a review');
    }
});