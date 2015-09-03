feature 'Admin panel' do
  given(:user) { FactoryGirl.create(:user, admin: true) }
  given!(:order) { FactoryGirl.create(:order, user: user, state: 'in_queue') }

  before { login_as user, :scope => :user }

  scenario 'Admin see orders with price and user info' do
    visit admin_orders_path
    expect(page).to have_content "#{order.user.name}"
    expect(page).to have_content "#{order.total_price}"
  end

  scenario 'Admin can turn order to next state' do
    visit admin_orders_path
    click_button('Next status')
    expect(page).to have_content 'in_delivery'
  end

  scenario 'Admin can cancel order' do
    visit admin_orders_path
    click_button('Cancelled')
    expect(page).not_to have_content "#{order.total_price}"
    expect(page).not_to have_content 'Next status'
    expect(page).not_to have_content 'Cancelled'
  end

end
