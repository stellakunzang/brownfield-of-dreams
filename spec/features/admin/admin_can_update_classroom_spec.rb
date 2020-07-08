require 'rails_helper'

feature "An admin can toggle a tutorial classroom status" do
  before :each do 
    admin = create(:admin)

    @tutorial1 = create(:tutorial)
    
  
    video0 = create(:video, tutorial: @tutorial1)
    video1 = create(:video, tutorial: @tutorial1)
    video2 = create(:video, tutorial: @tutorial1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
  end
  scenario "if classroom status is flase, toggle to true" do
    
    visit "/admin/dashboard"
    expect(page).to have_css('.admin-tutorial-card')

    within(first('.admin-tutorial-card')) do
      expect(page).to have_content('Classroom: false')
      click_button 'Toggle'
    end

    expect(current_path).to eq(admin_dashboard_path)
    
    expect(current_path).to eq(admin_dashboard_path)
    within(first('.admin-tutorial-card')) do
      expect(page).to have_content('Classroom: true')
      click_button 'Toggle'
    end
    
    expect(current_path).to eq(admin_dashboard_path)


    expect(current_path).to eq(admin_dashboard_path)
    within(first('.admin-tutorial-card')) do
      expect(page).to have_content('Classroom: false')
      click_button 'Toggle'
    end
  end
end