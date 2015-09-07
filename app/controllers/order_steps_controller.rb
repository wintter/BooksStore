class OrderStepsController < ApplicationController
  include UserCart::InitCart
  before_action :build_order
  include Wicked::Wizard, OrderChecker
  steps :order_address, :order_delivery, :order_payment, :order_confirm
  layout 'layouts/order'

  def show
    return check_previous_step if step.eql? :order_confirm
    render_wizard
  end

  def update
    @form.update(step, order_params)
    render_wizard @form
  end

  private

    def order_params
      params.permit(shipping_address: [:street_address, :zip, :city, :phone],
                    billing_address:  [:street_address, :zip, :city, :phone],
                    credit_card:      [:number, :CVV, :expiration_month, :expiration_year, :first_name, :last_name],
                    delivery: [:id])
    end

    def build_order
      @form = OrderForm.new(@cart)
    end

end
