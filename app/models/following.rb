class Following
  attr_reader :handle,
              :url

  def initialize(following_data)
    @handle = following_data[:login]
    @url = following_data[:html_url]
  end

  def in_system? 
  end

  def friend?
  end
end
