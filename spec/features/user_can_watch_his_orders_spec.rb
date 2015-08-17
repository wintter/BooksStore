feature 'Order page' do

  given(:user) { FactoryGirl.create(:user) }

  given!(:order) { FactoryGirl.create(:order, user: user, state: 'in_queue',
  billing_address: FactoryGirl.create(:address), shipping_address: FactoryGirl.create(:address),
  credit_card: FactoryGirl.create(:credit_card)) }

  given!(:cart) { FactoryGirl.create(:order, user: user) }

  before do
    login_as user, :scope => :user
    visit orders_path
  end

  scenario 'User sees their orders' do
    expect(page).to have_content "#{order.total_price}"
    expect(page).to have_content "#{order.state}"
    expect(page).to have_content "#{order.billing_address.street_address}"
    expect(page).to have_content "#{order.shipping_address.street_address}"
    expect(page).to have_content "#{order.credit_card.number}"
  end

  scenario 'User does not see order in progress' do
    expect(page).not_to have_content "#{cart.state}"
  end

end