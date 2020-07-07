require 'rails_helper'

describe "Registered User Profile Dashboard" do
  before :each do
    @user = create(:user, role: "default")
    stub_omniauth
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  it "sad: users not connected to github do not have github stats", :vcr do
    visit dashboard_path

    expect(page).to have_content("Connect to Github to See Github Details")
    expect(page).to_not have_content("Repositories")
    expect(page).to_not have_content("Followers")
    expect(page).to_not have_content("Following")
  end

  it "5 Github repositories are listed as links", :vcr do
    visit dashboard_path
    click_on "Connect to Github"

    expect(page).to have_content("Github")

    within(".github")do
      expect(page).to have_link("battleship")
      expect(page).to have_link("monster_shop_2003")
      expect(page).to have_link("adopt_dont_shop_2003_paired")
      expect(page).to have_link("activerecord-obstacle-course")
      # expect(page).to have_link(href: "https://github.com/", count: 5)
      expect(page).to have_css(".github_link", count: 5)
      # click_link("adopt_dont_shop_2003")
    end
    # expect(current_path).to eq("https://github.com/perryr16/adopt_dont_shop_2003")
  end

  it "Github followers are listed as links to profile", :vcr do
    visit dashboard_path
    click_on "Connect to Github"

    expect(page).to have_content("Followers")

    within(".github")do
      within(".followers")do
        expect(page).to have_link("stellakunzang")
        expect(page).to have_link("muydanny")
        expect(page).to have_link("dborski")
        #click_link("stellakunzang")
      end
    end
    # expect(current_path).to eq("https://github.com/stellakunzang")
  end

  it "Github followings are listed as links to profile", :vcr do
    visit dashboard_path
    click_on "Connect to Github"

    expect(page).to have_content("Following")

    within(".github")do
      within(".following")do
        expect(page).to have_link("stellakunzang")
        expect(page).to have_link("muydanny")
        expect(page).to have_link("dborski")
        #click_link("stellakunzang")
      end
    end
    # expect(current_path).to eq("https://github.com/stellakunzang")
  end

  it "user can create friendships if user is connected through github; follower", :vcr do

    friend = create(:user, role: "default")
    friend.update_attribute(:handle, "stellakunzang")
    visit dashboard_path
    click_on "Connect to Github"

    within(".github")do
      within(".followers")do
        click_link "Add as Friend"
      end
    end

    expect(current_path).to eq(dashboard_path)

    within(".github")do
      within(".following")do
        expect(page).to_not have_content("Add as Friend")
      end
    end

    within(".friendships")do
      expect(page).to have_content("stellakunzang")
    end
  end

  it "user can create friendships if user is connected through github; following", :vcr do

    friend = create(:user, role: "default")
    friend.update_attribute(:handle, "stellakunzang")
    visit dashboard_path
    click_on "Connect to Github"

    within(".github")do
      within(".followers")do
        click_link "Add as Friend"
      end
    end

    expect(current_path).to eq(dashboard_path)

    within(".github")do
      within(".following")do
        expect(page).to_not have_content("Add as Friend")
      end
    end

    within(".friendships")do
      expect(page).to have_content("stellakunzang")
    end
  end

  it "user cannot create fiendships if user is not connected through github", :vcr do
    visit dashboard_path
    click_on "Connect to Github"

    within(".github")do
      within(".following")do
        expect(page).to_not have_content("Add as Friend")
      end
    end

    within(".github")do
      within(".followers")do
        expect(page).to_not have_content("Add as Friend")
      end
    end

    within(".friendships")do
      expect(page).to_not have_content("stellakunzang")
    end
  end

  it "user can activate account" do

    visit "/users/#{@user.id}/activate"

    expect(page).to have_content('Thank you! Your account is now activated.')

    expect(page).to have_content("Status: Active")
  end
end

def stub_omniauth
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
    provider: 'github',
    credentials: {token: ENV['GITHUB_ROSS_AUTH_TOKEN']}
  })
end
