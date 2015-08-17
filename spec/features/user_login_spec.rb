feature 'Login' do

  given(:user) { FactoryGirl.create(:user) }

  before { visit new_user_session_path }

  scenario 'Visitor login successfully via login form' do

    within '#new_user' do
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button('Log in')
    end

    expect(page).to have_content 'Signed in successfully.'
    expect(page).to have_content 'Welcome to BooksStore'
    expect(page).to have_content 'My account'
    expect(page).to have_content 'Settings'
    expect(page).to have_content 'Logout'
  end

  scenario 'Visitor login failure via register form' do

    within '#new_user' do
      fill_in 'user[email]', with: ''
      fill_in 'user[password]', with: ''
      click_button('Log in')
    end

    expect(page).to have_content 'Invalid email or password.'
  end

end