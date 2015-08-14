feature 'Shopping cart' do

  given(:user) { FactoryGirl.create(:user) }
  given!(:book) { FactoryGirl.create(:book) }

  before do
    login_as user, :scope => :user
    visit order_items_path
  end

  scenario 'user see his items' do
    expect(page).to have_content 'Shopping cart'
  end


end