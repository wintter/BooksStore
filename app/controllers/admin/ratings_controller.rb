class Admin::RatingsController < ApplicationController
  before_filter :find_approved_ratings, only: :index
  authorize_resource class: self
  load_resource
  layout 'admin/layouts/application'
  include Admin::AdminHelper

  def index
  end

  def update
    @rating.update_attributes(approve: true)
    flash_and_redirect(@rating, nil)
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
