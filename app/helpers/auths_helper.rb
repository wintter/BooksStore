module AuthsHelper

  def login(user)
    remember_token = AuthsHelper.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, AuthsHelper.encrypt(remember_token))
  end

  def logout
    cookies.delete(:remember_token)
    reset_session
  end

  #return user by token
  def current_user
    User.find_by(remember_token: AuthsHelper.encrypt(cookies[:remember_token]))
  end

  #boolean login user
  def login?
    !User.find_by(remember_token: AuthsHelper.encrypt(cookies[:remember_token])).nil?
  end

  #callback for watch login user on site
  def check_login_user
    redirect_to new_auth_path, notice: 'Sign in for watching.' unless current_user
  end

  class << self

    def new_remember_token
      SecureRandom.urlsafe_base64
    end

    def encrypt(token)
      Digest::SHA1.hexdigest(token.to_s)
    end

  end

end
