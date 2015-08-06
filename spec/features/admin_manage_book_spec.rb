feature 'Admin panel' do
  let!(:book) { FactoryGirl.create(:book) }
  let(:user) { FactoryGirl.create(:user, admin: true) }
  before { login_as user, :scope => :user }

  feature 'from main page' do
    before { visit root_path }

    scenario 'Admin can move to admin panel and watch books' do
      click_link('Admin panel')

      expect(page).to have_content "#{book.title}"
      expect(page).to have_content "#{book.description}"
      expect(page).to have_content "#{book.price}"
      expect(page).to have_content "#{book.in_stock}"

    end
  end

  feature 'Books admin panel' do
    before { visit admin_books_path }

    scenario 'Admin want create a new book' do
      click_link('Add new book')

      expect(page).to have_field('book[title]')
      expect(page).to have_field('book[description]')
      expect(page).to have_field('book[price]')
      expect(page).to have_field('book[in_stock]')
      expect(page).to have_field('book[category_id]')
      expect(page).to have_field('book[author_id]')
      expect(page).to have_button('Create a book')
    end

    scenario 'Admin fill in book fields and click create' do
      click_link('Add new book')

      fill_in 'book[title]', with: 'test'
      fill_in 'book[description]', with: Faker::Name.title
      fill_in 'book[price]', with: 12
      fill_in 'book[in_stock]', with: 22
      click_button('Create a book')

      expect(page).to have_selector('.alert', text: 'Book test has successfully created')
    end

    scenario 'Admin want edit book' do
      click_link('Edit')

      expect(page).to have_field('book[title]')
      expect(page).to have_field('book[description]')
      expect(page).to have_field('book[price]')
      expect(page).to have_field('book[in_stock]')
      expect(page).to have_field('book[category_id]')
      expect(page).to have_field('book[author_id]')
      expect(page).to have_button('Update books')
    end

    scenario 'Admin fill in fields and update book' do
      click_link('Edit')

      fill_in 'book[title]', with: 'test'
      click_button('Update books')

      expect(page).to have_selector('.alert', text: 'Book test has successfully updated')

    end

  end

end
