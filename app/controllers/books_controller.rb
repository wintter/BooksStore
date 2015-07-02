class BooksController < ApplicationController
  before_action :check_login_user, only: [:show]

  def index
    if params[:id]
      @books = Book.where(category: params[:id])
      render :layout => false
    elsif params[:text]
      book_search
    else
      @categories = Category.all
      @books = Book.paginate(page: params[:page], :per_page => 10)
    end
  end

  def book_search
    if params[:type].eql? '1'
      @books = Book.where("title LIKE '%#{params[:text]}%'")
    else
      @author = Author.where("firstname LIKE '%#{params[:text]}%' OR lastname LIKE '%#{params[:text]}%'")
      @books = Book.where(author: @author)
    end
    render :layout => false
  end

  def show
    @book = Book.find(params[:id])
    @rating = Rating.where(book: @book, user: cur_user).first
    @rating ? @rating = @rating.rating_number : @rating = 0
    @review = Rating.where(book: @book, approve: true).all
  end

  def rate_book
    @rate = Rating.where(rating_params_watch).first
    if @rate
      Rating.update(@rate, rating_params)
    else
      Rating.create(rating_params)
    end
    render json: 1 if params[:rate][:rating_number]
    flash[:success] = 'Your review has been accepted for moderation'
    redirect_to action: 'show', id: params[:rate][:book_id]
  end

  private

    def rating_params
      params.require(:rate).permit(:rating_number, :book_id, :user_id, :review)
    end

    def rating_params_watch
      params.require(:rate).permit(:book_id, :user_id)
    end

end
