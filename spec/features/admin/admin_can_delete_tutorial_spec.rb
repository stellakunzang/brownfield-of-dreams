require 'rails_helper'

feature "An admin can delete a tutorial" do
  before :each do 
    admin = create(:admin)
    create_list(:tutorial, 2)
    
    @tutorial1 = Tutorial.first 
    video0 = create(:video, tutorial: @tutorial1)
    video1 = create(:video, tutorial: @tutorial1)
    video2 = create(:video, tutorial: @tutorial1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
  end
  scenario "and it should no longer exist" do
    
    visit "/admin/dashboard"
    expect(page).to have_css('.admin-tutorial-card', count: 2)

    within(first('.admin-tutorial-card')) do
      click_link 'Delete'
    end

    expect(page).to have_css('.admin-tutorial-card', count: 1)
  end

  # it "deleted tutorial has videos deleted as well" do
  #   expect(@tutorial1.videos.length).to eq(3)
  #   expect(Tutorial.all.length).to eq(2)
  #   expect(Video.all.length).to eq(3)

  #   within(first('.admin-tutorial-card')) do
  #     click_link 'Delete'
  #   end

  #   expect(Tutorial.all.length).to eq(1)
  #   expect(Video.all.length).to eq(0)

  # end
  


end
