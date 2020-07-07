require 'rails_helper'

describe 'A registered user' do
  before :each do 
    @tutorial_shoes = create(:tutorial, title: "How to Tie Your Shoes")
    @video1 = create(:video, title: "The Bunny Ears Technique", position: 0, tutorial: @tutorial_shoes)

    @tutorial_pbj= create(:tutorial, title: "How to Make a PBJ")
    @video2 = create(:video, title: "Is Jam Jelly?", position: 0, tutorial: @tutorial_pbj)
    @video3 = create(:video, title: "Which knife is the right knife?", position: 1, tutorial: @tutorial_pbj)
    
    @tutorial_car= create(:tutorial, title: "How to Make Drive a Car")
    @video4 = create(:video, title: "Appropriate times to play 'life is a highway'", position:0, tutorial: @tutorial_car)
    @video5 = create(:video, title: "How to ignore the check engine light", position: 1, tutorial: @tutorial_car)
    @video6 = create(:video, title: "Avoiding the horn", position: 2, tutorial: @tutorial_car)
    @user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    
  end
  it 'can add videos to their bookmarks' do

    visit tutorial_path(@tutorial_shoes)

    expect {
      click_on 'Bookmark'
    }.to change { UserVideo.count }.by(1)

    expect(page).to have_content("Bookmark added to your dashboard")
  end

  it "can't add the same bookmark more than once" do
    visit tutorial_path(@tutorial_shoes)

    click_on 'Bookmark'
    expect(page).to have_content("Bookmark added to your dashboard")
    click_on 'Bookmark'
    expect(page).to have_content("Already in your bookmarks")
  end

  it "bookmarked videos appear in dashboard" do
    visit tutorial_path(@tutorial_pbj)
    click_on @video3.title
    click_on 'Bookmark'
    click_on @video2.title
    click_on 'Bookmark'

    visit tutorial_path(@tutorial_car)
    click_on @video4.title
    click_on 'Bookmark'

    visit tutorial_path(@tutorial_shoes)
    click_on @video1.title
    click_on 'Bookmark'

    visit dashboard_path

    expect(@video1.title).to appear_before(@video2.title)
    expect(@video2.title).to appear_before(@video3.title)
    expect(@video3.title).to appear_before(@video4.title)
  end
  
end
