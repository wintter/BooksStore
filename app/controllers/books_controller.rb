class BooksController < ApplicationController
  before_filter :find_book, only: :index
  load_and_authorize_resource
  before_action :initialize_cart
  rescue_from ActiveRecord::RecordNotUnique, with: :record_not_unique

  def index
  end

  def show
    @rating = Rating.number @book, current_user
    @reviews = Rating.user_reviews @book
  end

  def add_to_cart
    @cart.cart_items.create(book: @book, quantity: 1)
    flash[:success] = 'Book "'<< @book.title << '" has added to cart'
    redirect_to(:back)
  end

  def add_to_wish_list
    current_user.wish_lists.create(book: @book)
    flash[:success] = 'Book "' << @book.title << '" has added to wish list'
    redirect_to (:back)
  end

  private

    def record_not_unique
      flash[:success] = 'You already add this book'
      redirect_to (:back)
    end

    def find_book
      if params[:category_id]
        @books = Book.where(category: params[:category_id])
        render layout: false
      elsif params[:search]
        @books = Book.search(params[:type], params[:search]).paginate(page: params[:page], per_page: 10)
      else
        @books = Book.paginate(page: params[:page], per_page: 10)
      end
    end

end
