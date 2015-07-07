class WishListsController < ApplicationController
  rescue_from ActiveRecord::RecordNotUnique, with: :record_not_unique

  def show
    @user = User.find(params[:id])
    @books = @user.books
  end

  def index
    @books = Book.all
  end

  def update
      cur_user.books.push Book.find(params[:id])
      flash[:success] = 'Book has added to wish list'
      redirect_to (:back)
  end

  def destroy
    cur_user.books.delete(Book.find params[:id])
    redirect_to action: 'show', id: cur_user.id
  end

  private

    def record_not_unique
      flash[:success] = 'You already add this book to wish list'
      redirect_to (:back)
    end

end
