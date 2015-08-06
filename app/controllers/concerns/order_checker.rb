module OrderChecker

  def check_previous_step
    return redirect_to wizard_path(:order_address) unless @cart.address
    return redirect_to wizard_path(:order_delivery) unless @cart.delivery
    return redirect_to wizard_path(:order_payment) unless @cart.credit_card
    render_wizard
  end

  def check_valid_request(entity, params)
    @info = entity.new(params)
    if @info.valid?
      @cart.create_address(params) if entity.eql? Address
      @cart.create_credit_card(params) if entity.eql? CreditCard
    else
      @address = @info if entity.eql? Address
      @credit_card = @info if entity.eql? CreditCard
      return false
    end
    true
  end

  def change_delivery(params)
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
