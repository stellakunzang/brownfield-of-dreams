require 'rails_helper'

# describe 'vistor can create an account', :js do
describe 'vistor can create an account' do
  it ' visits the home page', :vcr do
    email = 'jimbob@aol.com'
    first_name = 'Jim'
    last_name = 'Bob'
    password = 'password'

    visit '/'

    click_on 'Sign In'

    expect(current_path).to eq(login_path)

    click_on 'Sign up now.'

    expect(current_path).to eq(new_user_path)

    fill_in 'user[email]', with: email
    fill_in 'user[first_name]', with: first_name
    fill_in 'user[last_name]', with: last_name
    fill_in 'user[password]', with: password
    fill_in 'user[password_confirmation]', with: password

    click_on'Create Account'

    expect(current_path).to eq(dashboard_path)

    expect(page).to have_content(email)
    expect(page).to have_content(first_name)
    expect(page).to have_content(last_name)
    expect(page).to_not have_content('Sign In')
  end

  it "visitor can register and receive confirmation email", :vcr do
    visit '/'

    click_on 'Register'

    expect(current_path).to eq(register_path)

    email = 'jimbob@aol.com'
    first_name = 'Jim'
    last_name = 'Bob'
    password = 'password'

    fill_in 'user[email]', with: email
    fill_in 'user[first_name]', with: first_name
    fill_in 'user[last_name]', with: last_name
    fill_in 'user[password]', with: password
    fill_in 'user[password_confirmation]', with: password

    click_on 'Create Account'

    expect(current_path).to eq(dashboard_path)

    expect(page).to have_content("Logged in as #{first_name + " " + last_name}")
    expect(page).to have_content("This account has not yet been activated. Please check your email.")

    user = User.last
    activation_email = ActionMailer::Base.deliveries.last

    expect(activation_email.body).to have_content("Hello #{user.first_name}!")
    expect(activation_email.body).to have_content("You are almost finished setting up your new account!")
  end

end
