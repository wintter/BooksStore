class Admin::BooksController < ApplicationController
  load_and_authorize_resource
  layout 'admin/layouts/application'

  def index
  end

  def new
  end

  def edit
  end

  def create
    if @book.save
      flash[:success] = 'Book ' << @book.title << ' has successfully created'
      redirect_to action: 'index'
    else
      render 'new'
    end
  end

  def update
    if @book.update_attributes(book_params)
      flash[:success] = 'Book ' << @book.title << ' has successfully updated'
      redirect_to action: 'index'
    else
      render 'edit'
    end
  end

  def destroy
    @book.destroy
    redirect_to action: 'index'
  end

  private

    def book_params
      params.require(:book).permit(:title, :description, :price, :in_stock, :category_id, :author_id, :cover)
    end

end
