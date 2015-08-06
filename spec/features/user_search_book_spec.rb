feature 'Home pages' do

  let(:book) { FactoryGirl.create(:book, author: FactoryGirl.create(:author)) }
  let(:user) { FactoryGirl.create(:user) }

  before do
    login_as user, :scope => :user
    visit root_path
  end

  scenario 'User can search book by title' do
    fill_in 'search', with: book.title
    find('.search_icon').click
    expect(page).to have_content "#{book.title}"
    expect(page).to have_content "#{book.price}"
  end

  scenario 'User can search book by author' do
    fill_in 'search', with: book.author.firstname
    choose('type_2')
    find('.search_icon').click

    expect(page).to have_content "#{book.title}"
    expect(page).to have_content "#{book.price}"
  end


end