class YoutubeService
  def video_info(id)
    params = { part: 'snippet,contentDetails,statistics', id: id }
    get_json('youtube/v3/videos', params)
  end

  def playlist_info(id)
    params = { part: part_details, id: id }
    get_json('youtube/v3/playlists', params)
  end

  def playlist_items_info(id)
    results_count = playlist_info(id)[:items][0][:contentDetails][:itemCount]
    results_count = 50 if results_count > 50
    params = { part: part_details, playlistId: id, maxResults: results_count }
    playlist_videos = get_json('youtube/v3/playlistItems', params)
    next_page_playlist_items(playlist_videos, params)
  end

  def next_page_playlist_items(existing_videos, params)
    return existing_videos unless existing_videos[:nextPageToken]

    next_page_token = existing_videos[:nextPageToken]
    while next_page_token
      next_page_videos = get_json("youtube/v3/playlistItems?pageToken=#{next_page_token}", params)
      next_page_videos[:items].each do |new_video|
        existing_videos[:items] << new_video
      end
      next_page_token = next_page_videos[:nextPageToken]
    end
    existing_videos
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

  def part_details
    'snippet,contentDetails'
  end
end
