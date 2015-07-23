class Admin::AuthorsController < ApplicationController
  load_and_authorize_resource
  layout 'admin/layouts/application'

  def index
  end

  def new
  end

  def edit
  end

  def create
    if @author.save
      flash[:success] = 'Author ' << @author.firstname << ' has successfully created'
      redirect_to action: 'index'
    else
      render 'new'
    end
  end

  def update
    if @author.update_attributes(author_params)
      flash[:success] = 'Author ' << @author.firstname << ' has successfully updated'
      redirect_to action: 'index'
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
