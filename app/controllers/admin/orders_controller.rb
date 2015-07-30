class Admin::OrdersController < ApplicationController
  authorize_resource class: self
  load_resource
  layout 'admin/layouts/application'
  include Admin::AdminHelper

  def index
    @states = OrderState.all
  end

  def update
    @order.update_attributes(order_params)
    flash_and_redirect(@order, nil)
  end

  private

    def order_params
      params.require(:order).permit(:order_state_id)
    end

end
