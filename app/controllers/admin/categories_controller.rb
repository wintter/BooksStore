class Admin::CategoriesController < ApplicationController
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
    if @category.save
      flash_and_redirect(@catogory, 'create')
    else
      render 'new'
    end
  end

  def update
    if @category.update_attributes(category_params)
      flash_and_redirect(@catogory, 'update')
    else
      render 'edit'
    end
  end

  def destroy
    @category.destroy
    redirect_to action: 'index'
  end

  private

    def category_params
      params.require(:category).permit(:title)
    end

end
