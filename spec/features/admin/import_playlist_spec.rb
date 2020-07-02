require 'rails_helper'

describe "An Admin import a new playlist" do
  let(:admin)    { create(:admin) }

  scenario "by adding a playlist", :js do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit new_admin_tutorial_path

    # click_on "Import Youtube Playlist"
    # expect(current_path).to eq(new_admin_tutorial_playlist_path)

    fill_in "tutorial[title]", with: "Mod 0 Review"
    fill_in "tutorial[description]", with: "This is a review for Mod 0"
    fill_in "tutorial[thumbnail]", with: "x"
    fill_in "tutorial[playlist_id]", with: "PL1Y67f0xPzdMFq2S1bK7E7veT_BbK-zjt"

    click_on "Import Youtube Playlist"

    expect(current_path).to eq(admin_dashboard_path)
    
    expect(page).to have_content("Successfully created tutorial. View it here.")
    # click_link "View it here"

    tutorial = Tutorial.last
    visit tutorial_path(tutorial)
    expect(current_path).to eq(tutorial_path(tutorial))
    save_and_open_page
    # expect(page).to have_content(videos-and-stuff)
    # expect(page).to have_same_order_as_youtube_playlist

    # need to add all the videos that are inside of the playlist object


  end
end