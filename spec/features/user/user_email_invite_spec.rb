require 'rails_helper'

describe "Registered User Can Send Email Invite" do
  before :each do
    @user = create(:user, first_name: "ross", role: "default", active: true, handle: 'perryr16')
    stub_omniauth
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    visit dashboard_path 
    click_on "Connect to Github"
  end

  it "Happy: Email invite to a valid github handle", :vcr do
    visit dashboard_path
    expect(page).to have_content("Status: Active")

    click_on 'Send an Invite'
    expect(current_path).to eq('/invite')
    expect(current_path).to eq(invite_path)

    fill_in :github_handle, with: 'stellakunzang'
    click_on "Send Invite"

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content('Successfully sent invite!')

    invitation_email = ActionMailer::Base.deliveries.last

    expect(invitation_email.text_part.body).to have_content("Hello stellakunzang")
    expect(invitation_email.text_part.body).to have_content("perryr16 has invited you to join Brownfield of Dreams. \nYou can create an account here")
  end

  it "Sad: Email invite to a valid github handle", :vcr do
    visit dashboard_path
    expect(page).to have_content("Status: Active")

    click_on 'Send an Invite'
    expect(current_path).to eq('/invite')
    expect(current_path).to eq(invite_path)

    fill_in :github_handle, with: 'adfasdfasdfade5678asdf'
    click_on "Send Invite"

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("Please enter a valid github handle.")
    # expect(page).to have_content("The Github user you selected doesn't have an email address associated with their account.")
  end

  it "Sad: handle has no email", :vcr do
    visit dashboard_path
    expect(page).to have_content("Status: Active")

    click_on 'Send an Invite'
    expect(current_path).to eq('/invite')
    expect(current_path).to eq(invite_path)

    fill_in :github_handle, with: 'dog'
    click_on "Send Invite"

    expect(current_path).to eq(dashboard_path)
    # expect(page).to have_content("Please enter a valid github handle.")
    expect(page).to have_content("The Github user you selected doesn't have an email address associated with their account.")
  end

  end

def stub_omniauth
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
      :provider => 'github',
      credentials: {token: ENV['GITHUB_ROSS_AUTH_TOKEN']}      
    })
end