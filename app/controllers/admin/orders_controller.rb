class Admin::OrdersController < ApplicationController
  load_and_authorize_resource
  layout 'admin/layouts/application'

  def index
    @states = OrderState.all
  end

  def update
    @order.update_attributes(order_params)
    flash[:success] = 'Order has successfully updated'
    redirect_to action: 'index'
  end

  private

    def order_params
      params.require(:order).permit(:order_state_id)
    end

end
