feature 'User on book page' do
  given!(:book) { FactoryGirl.create(:book) }
  given(:user) { FactoryGirl.create(:user) }

  before do
    login_as user, :scope => :user
    visit book_path(book)
  end

  scenario 'User write a review' do
    fill_in 'review', with: Faker::Lorem.sentence
    click_button('Write a review')
    expect(page).to have_content 'Your review has been accepted for moderation'
  end

  scenario 'User click write a review when empty textarea' do
    fill_in 'review', with: ''
    click_button('Write a review')
    expect(page).to have_content 'Write a review'
  end

end
