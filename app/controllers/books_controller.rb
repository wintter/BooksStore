class BooksController < ApplicationController
  load_and_authorize_resource

  def index
    if params[:id]
      @books = Book.where(category: params[:id])
    elsif params[:text]
      @books = Book.search params[:type], params[:text]
    else
      @books = Book.paginate(page: params[:page], :per_page => 10)
    end
    render layout: false if params[:id] || params[:text]
  end

  def show
    @rating = Rating.get_rate @book, current_user
    @review = Rating.get_review @book
  end

end
