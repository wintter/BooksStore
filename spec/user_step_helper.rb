module UserStepHelper

  def fill_address
    fill_in 'billing_address[street_address]', with: 'test'
    fill_in 'billing_address[city]', with: 'test'
    fill_in 'billing_address[phone]', with: '123456'
    fill_in 'billing_address[zip]', with: '123'

    fill_in 'shipping_address[street_address]', with: 'test'
    fill_in 'shipping_address[city]', with: 'test'
    fill_in 'shipping_address[phone]', with: '123456'
    fill_in 'shipping_address[zip]', with: '123'
  end

  def fill_credit_card
    fill_in 'credit_card[number]', with: '12345'
    fill_in 'credit_card[CVV]', with: '123'
    fill_in 'credit_card[first_name]', with: 'fd'
    fill_in 'credit_card[last_name]', with: 'vv'
  end

end