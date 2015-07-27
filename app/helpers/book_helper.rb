module BookHelper

  def initialize *args
    super
    @categories = Category.all
    @authors = Author.all
  end

  def already_in_cart(book)
    @item = CartItem.where(book: book, cart: @cart).first
    if @item
      content_tag(:span, 'In cart', class: 'pull-right font_weight_600 label label-warning font_size_14')
    else
      link_to raw('<div class="pull-right book_preview_cart"><i class="glyphicon glyphicon-shopping-cart color_white font_size_20"></i></div>'), url_for(action: :add_to_cart, id: book)
    end
  end

end
