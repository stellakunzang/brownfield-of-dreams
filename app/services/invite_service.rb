class InviteService

  def conn
    Faraday.new("https://api.github.com")
  end

  def get_user(user)
    response = conn.get("/users/#{user}") 
    JSON.parse(response.body, symbolize_names: true)
  end

  def email_exists?(user)
    get_user(user)
    binding.pry
  end


end