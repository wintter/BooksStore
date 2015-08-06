feature 'Order pages' do

  let(:user) { FactoryGirl.create(:user) }
  let!(:book) { FactoryGirl.create(:book) }
  let(:order_item) { OrderItem.first }
  let!(:delivery) { FactoryGirl.create(:delivery) }

  before do
    login_as user, :scope => :user
    visit root_path
  end

  feature 'User create order' do
    before do
      find(:xpath, "//a[@href='/add_to_cart?id=1']").click
      first(:link,'Shopping cart').click
    end

    scenario 'User navigates to cart' do

      expect(page).to have_content 'Shopping cart'
      expect(page).to have_content order_item.book.title
      expect(page).to have_content order_item.quantity
      expect(page).to have_content order_item.book.price
      expect(page).to have_content 'Save and continue'

    end

    scenario 'User continue shopping and click continue' do
      find('.link_order').click

      expect(page).to have_field('billing_address[street_address]')
      expect(page).to have_field('billing_address[city]')
      expect(page).to have_field('billing_address[phone]')
      expect(page).to have_field('billing_address[zip]')
      expect(page).to have_field('shipping_address[street_address]')
      expect(page).to have_field('shipping_address[city]')
      expect(page).to have_field('shipping_address[phone]')
      expect(page).to have_field('shipping_address[zip]')
    end

    scenario 'User fill in address fields and moved to the next step' do
      visit order_path(:order_address)

      fill_address
      click_button('Save and continue')

      expect(page).to have_field('delivery')

    end

    scenario 'User change delivery and moved to the next step' do
      visit order_path(:order_delivery)

      choose('delivery_1')
      click_button('Save and continue')

      expect(page).to have_field('credit_card[number]')
      expect(page).to have_field('credit_card[CVV]')
      expect(page).to have_field('credit_card[first_name]')
      expect(page).to have_field('credit_card[last_name]')
      expect(page).to have_field('credit_card[expiration_month]')
      expect(page).to have_field('credit_card[expiration_year]')
    end

    scenario 'User passed all step and want to create order' do
      visit order_path(:order_address)

      fill_address
      click_button('Save and continue')

      choose('delivery_1')
      click_button('Save and continue')

      fill_credit_card
      click_button('Save and continue')

      expect(page).to have_content 'Confirm'
      expect(page).to have_content 'Total price'
      expect(page).to have_content 'Create order'
      expect(page).to have_field('coupon')
    end

    scenario 'User create order' do
      visit order_path(:order_address)

      fill_address
      click_button('Save and continue')

      choose('delivery_1')
      click_button('Save and continue')

      fill_credit_card
      click_button('Save and continue')

      click_link('Create order')

      expect(page).to have_content 'Your order has successfully created'

    end

  end

end