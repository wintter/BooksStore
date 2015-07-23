feature 'Book pages' do

  let(:book) { FactoryGirl.create(:book) }
  let(:user) { FactoryGirl.create(:user) }

  before do
    login_as user, :scope => :user
    visit book_path(book)
  end

  scenario 'Visitor can see book info' do
    expect(page).to have_content 'Description'
    expect(page).to have_content 'Available'
    expect(page).to have_content 'Category'
    expect(page).to have_content 'Publication date'
  end

  scenario 'Visitor can add to cart' do
    expect(page).to have_content 'Add to Cart'
  end

  scenario 'Visitor can write review' do
    expect(page).to have_content 'Write a review'
  end

  scenario 'Visitor can write review' do
    expect(page).to have_css('.glyphicon-heart')
  end

  scenario 'Visitor can rate book' do
    expect(page).to have_css('.rating_book')
  end

  scenario 'Visitor write a review' do
    fill_in 'review', with: Faker::Lorem.sentence
    click_button('Write a review')
    expect(page).to have_content 'Your review has been accepted for moderation'
  end

end