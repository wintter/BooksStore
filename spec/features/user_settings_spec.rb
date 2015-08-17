feature 'Login' do

  given(:user) { FactoryGirl.create(:user) }

  before do
    login_as user, :scope => :user
    visit edit_user_registration_path user
  end

=begin
  scenario 'Visitor modifies account information' do

    fill_in 'user[email]', with: 'test@gmail.com'
    fill_in 'user[current_password]', with: user.password
    click_button('Update')

    expect(page).to have_content 'Your account has been updated successfully.'
  end
=end

  scenario 'Visitor login failure via register form' do

    fill_in 'user[current_password]', with: ''
    find_button('Update').click

    expect(page).to have_content 'Current password can\'t be blank'
  end

end