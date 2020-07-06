require 'rails_helper'

describe YoutubeService do
  context "instance methods" do
    before(:each) do
      @id = "PL1Y67f0xPzdMFq2S1bK7E7veT_BbK-zjt"
      @service = YoutubeService.new
    end

    it "#playlist_info" do
      playlist_info = @service.playlist_info(@id)
      expect(playlist_info).to be_an Hash
      expect(playlist_info).to have_key :items
    end

    it "playlist_items_info" do
      playlist_items_info = @service.playlist_items_info(@id)
      expect(playlist_items_info[:items].length).to eq(10)
    end

    xit "can handle more than 50" do

    end
  end
end
