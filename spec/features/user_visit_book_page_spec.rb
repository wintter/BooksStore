feature 'Book pages' do

  let(:book) { FactoryGirl.create(:book) }
  let(:user) { FactoryGirl.create(:user) }

  before do
    login_as user, :scope => :user
    visit book_path(book)
  end

  scenario 'Visitor can see book info' do
    expect(page).to have_content "#{book.title}"
    expect(page).to have_content "#{book.description}"
    expect(page).to have_content "#{book.in_stock}"
    expect(page).to have_content "#{book.category.title}"
    expect(page).to have_content "#{book.author.firstname}"
    expect(page).to have_content "#{book.author.lastname}"
    expect(page).to have_content "#{book.price}"
  end

  scenario 'Visitor can write review and rate book' do
    expect(page).to have_content 'Write a review'
    expect(page).to have_css('.rating_book')
  end

end