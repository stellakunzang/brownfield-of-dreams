class YoutubeService
  def video_info(id)
    params = { part: 'snippet,contentDetails,statistics', id: id }
    get_json('youtube/v3/videos', params)
  end

  def playlist_info(id)
    params = { part: 'snippet,contentDetails', id: id }
    get_json('youtube/v3/playlists', params)
  end

  def playlist_items_info(id)
    params = { part: 'snippet', playlistId: id, maxResults: playlist_video_count(id) }
    get_json('youtube/v3/playlistItems', params)
  end
  
  def playlist_video_count(id)
    playlist_info(id)[:items][0][:contentDetails][:itemCount]
  end

  def playlist_video_ids(playlist_id)
    playlist_items_info(playlist_id)[:items].map do |item|
      item[:snippet][:resourceId][:videoId]  
    end
  end

  def new_playlist_videos_params(playlist_id)
    new_playlist_videos_params = []
    playlist_items_info(playlist_id)[:items].map do |item|
      new_playlist_video_params = {}
      new_playlist_video_params["title"] = item[:snippet][:title]
      new_playlist_video_params["description"] = item[:snippet][:description]  
      new_playlist_video_params["video_id"] = item[:snippet][:resourceId][:videoId]  
      new_playlist_video_params["thumbnail"] = item[:snippet][:thumbnails][:default][:url]
      new_playlist_videos_params << new_playlist_video_params
    end
    new_playlist_videos_params
  end
  private


  def get_json(url, params)
    response = conn.get(url, params)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: 'https://www.googleapis.com') do |f|
      f.adapter Faraday.default_adapter
      f.params[:key] = ENV['YOUTUBE_API_KEY']
    end
  end
end
