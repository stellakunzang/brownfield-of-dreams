require 'rails_helper'

describe YoutubeService do

  it "Playlist information is returned" do
    #playlist_url = https://www.youtube.com/playlist?list=PL1Y67f0xPzdMFq2S1bK7E7veT_BbK-zjt
    playlist_id = "PL1Y67f0xPzdMFq2S1bK7E7veT_BbK-zjt"
    playlist_info = YoutubeService.new.playlist_info(playlist_id)
    playlist_items_info = YoutubeService.new.playlist_items_info(playlist_id)
    binding.pry

    expect(playlist_info).to be_a Hash 
    expect(playlist_info[:kind]).to eq("youtube#playlistListResponse")
    expect(playlist_info[:items][0][:snippet][:title]).to eq("Mod 0 Review")
  end
end
