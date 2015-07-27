class Admin::RatingsController < ApplicationController
  before_filter :find_approved_ratings, only: :index
  load_and_authorize_resource
  layout 'admin/layouts/application'

  def index
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

  private

    def find_approved_ratings
      @ratings = Rating.approved
    end

end
