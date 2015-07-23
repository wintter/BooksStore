feature 'Login' do

  let(:user) { FactoryGirl.create(:user) }

  before do
    login_as user, :scope => :user
    visit edit_user_registration_path user
  end

  let(:correct_form) do
    fill_in 'user[email]', with: 'test@gmail.com'
    fill_in 'user[current_password]', with: user.password
    click_button('Update')
  end

  let(:incorrect_form) do
    click_button('Update')
  end

  scenario 'Visitor modifies account information' do

    within '#edit_user' do
      correct_form
    end

    expect(page).to have_content 'Your account has been updated successfully.'
  end

  scenario 'Visitor login failure via register form' do

    within '#edit_user' do
      incorrect_form
    end

    expect(page).to have_content 'Current password can\'t be blank'
  end

end