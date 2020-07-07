class GithubService
  def initialize(token)
    @token = token
  end

  def conn
    # Faraday.new("https://api.github.com?access_token=#{@token}")
    # Faraday.new(url: 'https://api.github.com?access_token=#{token}') do |faraday|
    #   faraday.headers['Authorization'] = ENV['GITHUB_API_KEY']
    Faraday.new("https://api.github.com")
      faraday.headers['Authorization'] = "token #{[@token]}"
    end
  end

  def get_url(url)
    response = conn.get("/user/#{url}")
    JSON.parse(response.body, symbolize_names: true)
  end

  def repos
    get_url('repos')
  end

  def followers
    get_url('followers')
  end

  def followings
    get_url('following')
  end
end
