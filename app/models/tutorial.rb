class Tutorial < ApplicationRecord
  has_many :videos, -> { order(position: :ASC) }, inverse_of: :tutorial
  acts_as_taggable_on :tags, :tag_list
  accepts_nested_attributes_for :videos

  def create_playlist_videos
    playlist_video_params.each do |params|
      videos.create(params)
    end
  end

  def playlist_video_json
    YoutubeService.new.playlist_items_info(playlist_id)
  end

  def playlist_video_params
    playlist_video_json[:items].map do |video|
      Hash[video_params_keys.zip(video_params_values(video))]
    end
  end

  def video_params_values(video)
    thumbnail = thumbnail_param(video)
    [video[:snippet][:title],
     video[:snippet][:description],
     video[:contentDetails][:videoId],
     thumbnail,
     video[:snippet][:position]]
  end

  def video_params_keys
    %i[title description video_id thumbnail position]
  end

  def thumbnail_param(video)
    if video[:snippet][:thumbnails] == {}
      ''
    else
      video[:snippet][:thumbnails][:default][:url]
    end
  end
end
