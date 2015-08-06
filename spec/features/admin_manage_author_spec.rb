feature 'Admin panel' do
  let!(:author) { FactoryGirl.create(:author) }
  let(:user) { FactoryGirl.create(:user, admin: true) }
  before { login_as user, :scope => :user }

  feature 'from main page' do
    before { visit root_path }

    scenario 'Admin can move to admin panel and watch author' do
      click_link('Admin panel')
      click_link('All authors')

      expect(page).to have_content "#{author.firstname}"
      expect(page).to have_content "#{author.lastname}"
      expect(page).to have_content "#{author.biography}"

    end
  end

  feature 'Categories admin panel' do
    before { visit admin_authors_path }

    scenario 'Admin want create a new book' do
      click_link('Add new author')

      expect(page).to have_field('author[firstname]')
      expect(page).to have_button('Create author')
    end

    scenario 'Admin fill in category fields and click create' do
      click_link('Add new author')

      fill_in 'author[firstname]', with: 'test'
      fill_in 'author[lastname]', with: 'test'
      fill_in 'author[biography]', with: 'test'
      click_button('Create author')

      expect(page).to have_selector('.alert', text: 'Author test has successfully created')
    end

    scenario 'Admin want edit author' do
      click_link('Edit')

      expect(page).to have_field('author[firstname]')
      expect(page).to have_field('author[lastname]')
      expect(page).to have_field('author[biography]')
      expect(page).to have_button('Update author')
    end

    scenario 'Admin fill in fields and update author' do
      click_link('Edit')

      fill_in 'author[firstname]', with: 'test'
      click_button('Update author')

      expect(page).to have_selector('.alert', text: 'Author test has successfully updated')

    end

  end

end
