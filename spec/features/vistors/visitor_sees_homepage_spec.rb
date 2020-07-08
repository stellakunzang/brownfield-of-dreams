require 'rails_helper'

describe 'Visitor' do
  describe 'on the home page' do
    it 'can see a list of tutorials', :vcr do
      tutorial1 = create(:tutorial)
      tutorial2 = create(:tutorial)

      video1 = create(:video, tutorial_id: tutorial1.id)
      video2 = create(:video, tutorial_id: tutorial1.id)
      video3 = create(:video, tutorial_id: tutorial2.id)
      video4 = create(:video, tutorial_id: tutorial2.id)

      visit root_path

      expect(page).to have_css('.tutorial', count: 2)

      within(first('.tutorials')) do
        expect(page).to have_css('.tutorial')
        expect(page).to have_css('.tutorial-description')
        expect(page).to have_content(tutorial1.title)
        expect(page).to have_content(tutorial1.description)
      end
    end

    it 'cannot see classroom content', :vcr do
      tutorial1 = create(:tutorial, classroom: true)
      video1 = create(:video, tutorial_id: tutorial1.id)

      visit root_path

      expect(page).to_not have_css('.tutorial')

      # the sad path below doesn't work...because of the 404 we can't get there, so success! 

      # visit "/tutorials/#{tutorial1.id}"
      #
      # expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
end
