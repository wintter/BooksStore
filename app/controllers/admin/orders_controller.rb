class Admin::OrdersController < ApplicationController
  authorize_resource class: self
  load_resource
  layout 'admin/layouts/application'
  include Admin::AdminHelper

  def index
    @orders = @orders.valid_orders
  end

  def update
    params[:cancel] ? (@order.cancel!) : (@order.next_state)
    flash_and_redirect(@order, nil)
  end

end
