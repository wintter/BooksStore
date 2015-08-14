feature 'Admin panel' do
  given!(:category) { FactoryGirl.create(:category) }
  given(:user) { FactoryGirl.create(:user, admin: true) }
  before { login_as user, :scope => :user }

  feature 'from main page' do
    before { visit root_path }

    scenario 'Admin can move to admin panel and watch category' do
      click_link('Admin panel')
      click_link('All categories')

      expect(page).to have_content "#{category.title}"

    end
  end

  feature 'Categories admin panel' do
    before { visit admin_categories_path }

    scenario 'Admin want create a new book' do
      click_link('Add new category')

      expect(page).to have_content('Add new category')
      expect(page).to have_button('Create a category')
    end

    scenario 'Admin fill in category fields and click create' do
      click_link('Add new category')

      fill_in 'category[title]', with: 'test'
      click_button('Create a category')

      expect(page).to have_selector('.alert', text: 'Category test has successfully created')
    end

    scenario 'Admin want edit category' do
      click_link('Edit')

      expect(page).to have_content('Edit category')
      expect(page).to have_button('Update a category')
    end

    scenario 'Admin fill in fields and update category' do
      click_link('Edit')

      fill_in 'category[title]', with: 'test'
      click_button('Update a category')

      expect(page).to have_selector('.alert', text: 'Category test has successfully updated')

    end

  end

end
