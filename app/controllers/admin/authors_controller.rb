class Admin::AuthorsController < ApplicationController
  before_action :check_login_user
  before_action :check_admin, only: [:index, :new, :create, :edit, :update, :destroy]
  layout 'admin/layouts/application'

  def index
    @authors = Author.all
  end

  def new
    @author = Author.new
  end

  def edit
    @author = Author.find(params[:id])
  end

  def create
    @author = Author.new(authors_params)
    if @author.save
      flash[:success] = 'Author ' << @author.firstname << ' has successfully created'
      redirect_to action: 'index'
    else
      render 'new'
    end
  end

  def update
    @author = Author.find(params[:id])
    if @author.update_attributes(authors_params)
      flash[:success] = 'Author ' << @author.firstname << ' has successfully updated'
      redirect_to action: 'index'
    else
      render 'edit'
    end
  end

  def destroy
    Author.find(params[:id]).destroy
    redirect_to action: 'index'
  end

  private

    def authors_params
      params.require(:author).permit(:firstname, :lastname, :biography)
    end

end
