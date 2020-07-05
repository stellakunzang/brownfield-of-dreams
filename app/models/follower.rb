class Follower
  attr_reader :handle,
              :url

  def initialize(follower_data)
    @handle = follower_data[:login]
    @url = follower_data[:html_url]
  end

  def in_system?
    binding.pry
  end

  def friend?
    binding.pry
  end
end
