$(document).ready(function() {
    $('[data-toggle="popover"]').popover();
});

$(document).on('click', '.category_id a', function() {
    var cat_id = $(this).data('id');
    $('.category_name').text($(this).data('title'));
    $.ajax({
        type: "GET",
        data: {id: cat_id},
        dataType: "html",
        url: "/books",
        success: function(response) {
            $('.all_books').html(response);
        }
    });
});
$(document).on('click', '.link_credit_card', function() {
    if($('.credit_carts_forms').hasClass('hide')) {
        $('.credit_carts_forms').removeClass('hide');
    } else {
        $('.credit_carts_forms').addClass('hide');
    }
});
$(document).on('click', '.search_icon', function() {
        $('[data-toggle="popover"]').popover('show');
});
$(document).on('click', '.check_search input', function() {
        $('.search').attr('data-search-type', $(this).val());
});
$(document).on('keyup', '.search', function() {
    var type_search = $('.search').attr('data-search-type');
        $.ajax({
            type: "GET",
            data: { text: $('.search').val(), type: type_search },
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