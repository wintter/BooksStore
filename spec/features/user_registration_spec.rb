feature 'Registration' do
  before { visit new_user_registration_path }

  scenario 'click sign up with blank fields' do
    expect { click_button('Sign up') }.not_to change(User, :count)
  end

  scenario 'Visitor registers successfully via register form' do

    within '#new_user' do
      fill_in 'user[name]', with: 'test'
      fill_in 'user[email]', with: Faker::Internet.email
      fill_in 'user[password]', with: '12345678'
      fill_in 'user[password_confirmation]', with: '12345678'
      click_button('Sign up')
    end

    expect(page).not_to have_content 'Sign up'
    expect(page).to have_content 'You have signed up successfully.'
    expect(page).to have_content 'My account'
    expect(page).to have_content 'Settings'
    expect(page).to have_content 'Logout'
  end

  scenario 'Visitor registers failure via register form' do

    within '#new_user' do
      fill_in 'user[name]', with: ''
      fill_in 'user[email]', with: ''
      fill_in 'user[password]', with: '12345678'
      fill_in 'user[password_confirmation]', with: ''
      click_button('Sign up')
    end

    expect(page).not_to have_content 'Sign up'
    expect(page).to have_content 'Email can\'t be blank'
    expect(page).to have_content 'Name can\'t be blank'
    expect(page).to have_content 'Password confirmation doesn\'t match Password'
  end

end