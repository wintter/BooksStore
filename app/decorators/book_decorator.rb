class BookDecorator < Draper::Decorator
  delegate_all

  def public_date
    object.publication_date.strftime("%d %B %Y")
  end

  def category_name
    object.category.title
  end

  def author_name
    object.author.firstname + object.author.lastname
  end

  def in_cart
    @item = OrderItem.find_by(book: object, order: h.current_user.cart)
    if @item
      h.content_tag :span, 'In cart', class: 'pull-right font_weight_600 label label-warning font_size_14'
    else
      h.link_to h.raw('<div class="pull-right book_preview_cart"><i class="glyphicon glyphicon-shopping-cart color_white font_size_20"></i></div>'),
                h.url_for(action: :add_to_cart, id: object)
    end
  end

  def in_wish_list
    @wish = WishList.where(user: h.current_user, book: object).first
    if @wish
      h.content_tag(:span, 'In wish list', class: 'pull-right font_weight_600 label label-warning font_size_14')
    else
      h.link_to h.raw('<div class="color_white add_to_cart_button"><i class="glyphicon glyphicon-heart font_size_20"></i></div>'),
                h.url_for(action: :add_to_wish_list, id: object)
    end
  end

end
