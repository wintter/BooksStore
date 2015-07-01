class WishListsController < ApplicationController
  #before_action :check_current_user, only: [:show]

  def show
    @user = User.find(params[:id])
    @books = @user.books
  end

  def index
    @books = Book.all
  end

  def update
    begin
      cur_user.books.push Book.find(params[:id])
      flash[:success] = 'Book has added to wish list'
    rescue ActiveRecord::RecordNotUnique
      flash[:success] = 'You already add this book to wish list'
    ensure
      redirect_to (:back)
    end
  end

  def destroy
    cur_user.books.delete(Book.find params[:id])
    redirect_to action: 'show', id: cur_user.id
  end

end
