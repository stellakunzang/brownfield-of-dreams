require 'rails_helper'

describe YoutubeService do

  it "Playlist information is returned" do
    #playlist_url = https://www.youtube.com/playlist?list=PL1Y67f0xPzdMFq2S1bK7E7veT_BbK-zjt
    playlist_id = "PL1Y67f0xPzdMFq2S1bK7E7veT_BbK-zjt"
    service = YoutubeService.new
    playlist_info = service.playlist_info(playlist_id)
    playlist_items_info = service.playlist_items_info(playlist_id)
    playlist_video_ids = service.playlist_video_ids(playlist_id)
    new_playlist_videos_params = service.new_playlist_videos_params(playlist_id)


    expect(playlist_info).to be_a Hash 
    expect(playlist_info[:kind]).to eq("youtube#playlistListResponse")
    expect(playlist_info[:items][0][:snippet][:title]).to eq("Mod 0 Review")
  end
end
