class Invite 

  def initialize(token)
    @token = token
  end

  def send_invite(handle, user)
      @invitee_handle = handle
      @invitee_email = invitee_email(handle)
      @user = user
      InvitationMailer.with(user: @user, 
                            invitee_email: @invitee_email, 
                            invitee_handle: @invitee_handle)
                            .invitation_email
                            .deliver_now
  end

  def email_service
    email_service = GithubService.new(@token)
  end

  def user_search(handle)
    email_service.user_search(handle)
  end
  
  def github_email_missing?(handle)
    response = user_search(handle)
    response[:email].nil?
  end

  def github_handle_missing?(handle)
    response = user_search(handle)
    response[:login].nil?
  end

  def invitee_email(handle)
    response = user_search(handle)
    response[:email]
  end


end