feature 'Shopping cart' do
  Capybara.current_driver = :selenium
  given(:user) { FactoryGirl.create(:user) }

  given!(:wish_list) { FactoryGirl.create(:wish_list, user: user) }

  before do
    login_as user, :scope => :user
    visit wish_lists_path
  end

  scenario 'User sees their wish list' do
    expect(page).to have_content 'My wish list'
    expect(page).to have_content "#{wish_list.book.title}"
    expect(page).to have_content "#{wish_list.book.price}"
  end

end