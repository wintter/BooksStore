module OrderChecker

  def check_previous_step
    return redirect_to wizard_path(:order_address) unless @cart.billing_address && @cart.shipping_address
    return redirect_to wizard_path(:order_delivery) unless @cart.delivery
    return redirect_to wizard_path(:order_payment) unless @cart.credit_card
    render_wizard
  end

end
