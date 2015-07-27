module WishListsHelper

  def already_in_wish_list(book)
    @wish = WishList.where(user: current_user, book: book).first
    if @wish
      content_tag(:span, 'In wish list', class: 'pull-right font_weight_600 label label-warning font_size_14')
    else
      link_to raw('<div class="color_white add_to_cart_button">
    <i class="glyphicon glyphicon-heart font_size_20"></i>
      </div>'), url_for(action: :add_to_wish_list, id: @book)
    end
  end

end
