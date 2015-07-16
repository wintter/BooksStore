class Admin::CategoriesController < ApplicationController
  load_and_authorize_resource
  skip_authorize_resource :only => [:new]
  layout 'admin/layouts/application'

  def index
  end

  def new
  end

  def edit
  end

  def create
    if @category.save
      flash[:success] = 'Category ' << @category.title << ' has successfully created'
      redirect_to action: 'index'
    else
      render 'new'
    end
  end

  def update
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
