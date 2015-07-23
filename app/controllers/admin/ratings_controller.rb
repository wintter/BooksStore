class Admin::RatingsController < ApplicationController
  load_and_authorize_resource
  layout 'admin/layouts/application'

  def index
    @ratings = Rating.approved
  end

  def update
    @rating.update_attributes(approve: true)
    flash[:success] = 'Review has successfully approved'
    redirect_to action: 'index'
  end

  def destroy
    @rating.destroy
    redirect_to action: 'index'
  end

end
