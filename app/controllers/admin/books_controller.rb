class Admin::BooksController < ApplicationController
  load_and_authorize_resource
  skip_authorize_resource :only => [:new]
  layout 'admin/layouts/application'

  def index
  end

  def new
    @categories = Category.all
    @authors = Author.all
  end

  def edit
    @categories = Category.all
    @authors = Author.all
  end

  def create
    if @book.save
      Book.save_image params[:book][:image], @book.id if params[:book][:image]
      flash[:success] = 'Book ' << @book.title << ' has successfully created'
      redirect_to action: 'index'
    else
      @categories = Category.all
      @authors = Author.all
      render 'new'
    end
  end

  def update
    if @book.update_attributes(book_params)
      Book.save_image params[:book][:image], params[:id] if params[:book][:image]
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
      params.require(:book).permit(:title, :description, :price, :in_stock, :category_id, :author_id)
    end

end
