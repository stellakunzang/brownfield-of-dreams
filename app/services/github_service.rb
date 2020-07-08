class GithubService
  def initialize(token)
    @token = token
  end

  def conn
    Faraday.new('https://api.github.com')
  end

  def get_url(url)
    response = conn.get("/user/#{url}") do |res|
      res.headers['Authorization'] = "token #{@token}"
    end
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

  def user_search(handle)
    response = conn.get("/users/#{handle}") do |res|
      res.headers['Authorization'] = "token #{@token}"
    end
    JSON.parse(response.body, symbolize_names: true)
  end
end
