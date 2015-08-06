module OrderChecker

  def check_previous_step
    return redirect_to wizard_path(:order_address) unless @cart.billing_address && @cart.shipping_address
    return redirect_to wizard_path(:order_delivery) unless @cart.delivery
    return redirect_to wizard_path(:order_payment) unless @cart.credit_card
    render_wizard
  end

  def create_credit_card(params)
    @credit_card = CreditCard.new(params)
    if @credit_card.valid?
      unless @cart.credit_card
        @cart.create_credit_card(params)
      else
        @cart.credit_card.update(params)
      end
    else
      return false
    end
    true
  end

  def create_addresses(billing, shipping)
    @billing_address = Address.new(billing)
    @shipping_address = Address.new(shipping)

    if @billing_address.valid? && @shipping_address.valid?
      if @cart.billing_address && @cart.shipping_address
        @cart.billing_address.update(billing)
        @cart.shipping_address.update(shipping)
      else
        @cart.update(billing_address: @billing_address, shipping_address: @shipping_address)
      end
      true
    else
      false
    end

  end

  def create_delivery(params)
    if params
      @cart.update(delivery_id: params)
      true
    else
      flash.now[:error] = 'Change delivery'
      @delivery = Delivery.all
      false
    end
  end

end
