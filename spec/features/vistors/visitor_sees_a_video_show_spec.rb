require 'rails_helper'

describe 'visitor sees a video show' do
  before :each do 
    @tutorial_open = create(:tutorial)
    @video1 = create(:video, tutorial_id: @tutorial_open.id)

    @tutorial_private = create(:tutorial, classroom: true)
    @video2 = create(:video, tutorial_id: @tutorial_private.id)
  end
  it 'vistor clicks on a tutorial title from the home page', :vcr do

    visit '/'

    click_on @tutorial_open.title

    expect(current_path).to eq(tutorial_path(@tutorial_open))
    expect(page).to have_content(@video1.title)
    expect(page).to have_content(@tutorial_open.title)
  end

  it "visitors cannot see videos marked as classroom content", :vcr do
    user = User.create!(email: 'admin@example.com', first_name: 'Bossy', last_name: 'McBosserton', password:  "password", role: :default)
    visit '/login'

    fill_in "session[email]", with: user.email
    fill_in "session[password]", with: user.password
    click_on "Log In"

    visit '/'

    expect(page).to have_content(@tutorial_open.title)
    expect(page).to have_content(@tutorial_private.title)
    click_on 'Profile'
    click_on 'Log Out'

    expect(page).to have_content(@tutorial_open.title)
    expect(page).to_not have_content(@tutorial_private.title)

  end
end
