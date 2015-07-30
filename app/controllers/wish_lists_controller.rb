class WishListsController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def destroy
    @wish_list.destroy
    redirect_to action: 'index'
  end


end
