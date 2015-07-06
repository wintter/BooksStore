class Admin::BooksController < ApplicationController
  before_action :check_admin, only: [:index, :new, :create, :edit, :update, :destroy]
  before_action :check_login_user
  layout 'admin/layouts/application'

  def index
    @books = Book.all
  end

  def new
    @categories = Category.all
    @authors = Author.all
    @book = Book.new
  end

  def edit
    @categories = Category.all
    @authors = Author.all
    @book = Book.find(params[:id])
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      flash[:success] = 'Book ' << @book.title << ' has successfully created'
      redirect_to action: 'index'
    else
      @categories = Category.all
      @authors = Author.all
      render 'new'
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update_attributes(book_params)
      flash[:success] = 'Book ' << @book.title << ' has successfully updated'
      redirect_to action: 'index'
    else
      render 'edit'
    end
  end

  def destroy
    Book.find(params[:id]).destroy
    redirect_to root_path
  end

  private

    def book_params
      params.require(:book).permit(:title, :description, :price, :in_stock, :category_id, :author_id)
    end

end
