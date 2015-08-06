module UserStepHelper

  def fill_address
    fill_in 'address[street_address]', with: 'test'
    fill_in 'address[city]', with: 'test'
    fill_in 'address[phone]', with: '123456'
    fill_in 'address[zip]', with: '123'
  end

  def fill_credit_card
    fill_in 'credit_card[number]', with: '12345'
    fill_in 'credit_card[CVV]', with: '123'
    fill_in 'credit_card[first_name]', with: 'fd'
    fill_in 'credit_card[last_name]', with: 'vv'
  end

end