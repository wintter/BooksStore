class BooksController < ApplicationController
  before_action :check_login_user, only: [:show, :rate_book]

  def index
    if params[:id]
      @books = Book.where(category: params[:id])
    elsif params[:text]
      @books = Book.search params[:type], params[:text]
    else
      @categories = Category.all
      @books = Book.paginate(page: params[:page], :per_page => 10)
    end
    render layout: false if params[:id] || params[:text]
  end

  def show
    @book = Book.find(params[:id])
    @rating = Rating.get_rate @book, current_user
    @review = Rating.get_review @book
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
