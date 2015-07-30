class Admin::AuthorsController < ApplicationController
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
    if @author.save
      flash_and_redirect(@author, 'create')
    else
      render 'new'
    end
  end

  def update
    if @author.update_attributes(author_params)
      flash_and_redirect(@author, 'update')
    else
      render 'edit'
    end
  end

  def destroy
    @author.destroy
    redirect_to action: 'index'
  end

  private

    def author_params
      params.require(:author).permit(:firstname, :lastname, :biography)
    end

end
