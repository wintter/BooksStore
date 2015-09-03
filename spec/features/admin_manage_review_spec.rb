feature 'Admin panel' do
  given!(:rating) { FactoryGirl.create(:rating, approve: false) }
  given(:user) { FactoryGirl.create(:user, admin: true) }
  before { login_as user, :scope => :user }

  feature 'from main page' do
    before { visit root_path }

    scenario 'Admin can move to admin panel and watch ratings' do
      click_link('Admin panel')
      click_link('All ratings')

      expect(page).to have_content "#{rating.review}"

    end
  end

  feature 'Ratings admin panel', js: true do
    before { visit admin_ratings_path }

    xscenario 'Admin approved review' do
      click_link('Approve')
      page.accept_alert

      expect(page).to have_selector('.alert', text: 'Review has successfully approved')
    end

  end

end
