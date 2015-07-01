class Admin::CategoriesController < ApplicationController
  before_action :check_admin, only: [:index, :new, :create, :edit, :update, :destroy]
  before_action :check_login_user
  layout 'admin/layouts/application'

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def edit
    @category = Category.find(params[:id])
  end

  def create
    @category = Category.new(categories_params)
    if @category.save
      flash[:success] = 'Category ' << @category.title << ' has successfully created'
      redirect_to action: 'index'
    else
      render 'new'
    end
  end

  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(categories_params)
      flash[:success] = 'Category ' << @category.title << ' has successfully updated'
      redirect_to action: 'index'
    else
      render 'edit'
    end
  end

  def destroy
    Category.find(params[:id]).destroy
    redirect_to action: 'index'
  end

  private

    def categories_params
      params.require(:category).permit(:title)
    end

end
