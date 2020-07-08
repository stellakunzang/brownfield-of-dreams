require 'rails_helper'

describe "Registered User Without Github" do

  it "If user is not connected to github, user cannot send email invite", :vcr do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit dashboard_path

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content('Connect to Github to send invites')
    expect(page).to have_content('Send an Invite')
    expect(page).to_not have_button('Send an Invite')
    expect(page).to_not have_link('Send an Invite')

  end
  
end