class Admin::ReviewsController < ApplicationController
  before_action :check_login_user
  layout 'admin/layouts/application'

  def index
    @reviews = Rating.approved
  end

  def update
    Rating.find(params[:id]).update_attributes(approve: 1)
    flash[:success] = 'Review has successfully approved'
    redirect_to action: 'index'
  end

  def destroy
    Rating.find(params[:id]).destroy
    redirect_to action: 'index'
  end

end
