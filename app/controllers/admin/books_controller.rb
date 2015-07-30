class Admin::BooksController < ApplicationController
  authorize_resource class: self
  load_resource
  layout 'admin/layouts/application'
  include Admin::AdminHelper

  def index
  end

  def new
  end

  def edit
  end

  def create
    if @book.save
      flash_and_redirect(@book, 'create')
    else
      render 'new'
    end
  end

  def update
    if @book.update_attributes(book_params)
      flash_and_redirect(@book, 'update')
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
