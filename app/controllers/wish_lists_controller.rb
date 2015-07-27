class WishListsController < ApplicationController
  load_and_authorize_resource through: :current_user

  def index
  end

  def destroy
    @wish_list.destroy
    redirect_to action: 'index'
  end


end
