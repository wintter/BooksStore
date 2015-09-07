class OrderForm
  include ActiveModel::Model

  def initialize(order)
    @order = order
  end

  def billing_address
    @order.billing_address || @order.user.billing_address || Address.new
  end

  def shipping_address
    @order.shipping_address || @order.user.shipping_address || Address.new
  end

  def credit_card
    @order.credit_card || CreditCard.new
  end

  def delivery
    Delivery.all
  end

  def create_addresses(billing, shipping)
    if @order.billing_address && @order.shipping_address
      @order.billing_address.assign_attributes(billing)
      @order.shipping_address.assign_attributes(shipping)
    else
      @order.create_billing_address(billing)
      @order.create_shipping_address(shipping)
    end
  end

  def create_credit_card(credit_card)
    if @order.credit_card
      @order.credit_card.assign_attributes(credit_card)
    else
      @order.create_credit_card(credit_card)
    end
  end

  def create_delivery(delivery)
    if Delivery.find_by_id(delivery[:id])
      if @order.delivery
      @order.update(delivery_id: delivery[:id])
    else
      @order.delivery_id = delivery[:id]
      end
    end
  end

  def save
    @order.save
  end

  def update(step, params)
      case step
        when :order_address
          params[:shipping_address] = params[:billing_address] if params[:shipping][:check].eql? '1'
          create_addresses(params[:billing_address], params[:shipping_address])
        when :order_delivery
          create_delivery(params[:delivery])
        when :order_payment
          create_credit_card(params[:credit_card])
        else
          @order.create
      end
  end


end