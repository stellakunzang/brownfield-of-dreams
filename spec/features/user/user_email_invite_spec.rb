require 'rails_helper'

describe "Registered User Can Send Email Invite" do
  before :each do
    @user = create(:user, role: "default", active: true)
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

    fill_in 'invite[github_handle]', with: 'stellakunzang'
    click_on "Send Invite"

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content('Successfully sent invite!')
  end

  it "Sad: Email invite to a valid github handle", :vcr do
    visit dashboard_path
    expect(page).to have_content("Status: Active")

    click_on 'Send an Invite'
    expect(current_path).to eq('/invite')
    expect(current_path).to eq(invite_path)

    fill_in 'invite[github_handle]', with: 'dog'
    click_on "Send Invite"

    expect(current_path).to eq(dashboard_path)
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