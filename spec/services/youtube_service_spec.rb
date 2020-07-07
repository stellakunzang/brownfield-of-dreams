require 'rails_helper'

describe YoutubeService do
  context "instance methods" do
    before(:each) do
      @id = "PL1Y67f0xPzdMFq2S1bK7E7veT_BbK-zjt"
      @service = YoutubeService.new
    end

    it "#playlist_info" , :vcr do
      playlist_info = @service.playlist_info(@id)
      expect(playlist_info).to be_an Hash
      expect(playlist_info).to have_key :items
    end

    it "#playlist_items_info", :vcr do
      playlist_items_info = @service.playlist_items_info(@id)
      expect(playlist_items_info[:items].length).to eq(10)
    end

    it "can handle more than 50", :vcr do
      id_50_plus = "PLw3DVCAvDGUtrWrm0s2zxnbrgzkG5YAfF"
      playlist_items_info = @service.playlist_items_info(id_50_plus)
      expect(playlist_items_info[:items].length).to eq(127)
    end
  end
end
