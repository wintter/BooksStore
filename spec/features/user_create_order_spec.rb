feature 'Order pages' do

  given(:user) { FactoryGirl.create(:user) }
  given!(:book) { FactoryGirl.create(:book) }
  given(:order_item) { OrderItem.first }
  given!(:delivery) { FactoryGirl.create(:delivery) }

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

    end

    scenario 'User continue shopping and click continue' do
      find('.link_order').click

      expect(page).to have_content('Billing information')
      expect(page).to have_content('Shipping information')
      expect(page).to have_selector(:button , 'Save and continue')
    end

    scenario 'User see checkout when shopping' do
      find('.link_order').click

      expect(page).to have_selector(:link , 'ADDRESS')
      expect(page).to have_selector(:link , 'DELIVERY')
      expect(page).to have_selector(:link , 'PAYMENT')
      expect(page).to have_selector(:link , 'CONFIRM')
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

      expect(page).to have_content('Fill credit card informtion')
      expect(page).to have_selector(:button , 'Save and continue')
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