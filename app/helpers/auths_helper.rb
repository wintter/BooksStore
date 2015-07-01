module AuthsHelper

  def login(user)
    remember_token = AuthsHelper.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, AuthsHelper.encrypt(remember_token))
  end

  def logout
    cookies.delete(:remember_token)
  end

  #return user by token
  def cur_user
    User.find_by(remember_token: AuthsHelper.encrypt(cookies[:remember_token]))
  end

  #boolean login user
  def login?
    !User.find_by(remember_token: AuthsHelper.encrypt(cookies[:remember_token])).nil?
  end

  #callback check admin
  def check_admin
    redirect_to root_url unless cur_user.admin?
  end

  #callback for check current user, user with id 50 cant /users/51/edit
  def check_current_user
    redirect_to root_path, notice: 'Permission denied' unless User.find(params[:id]).eql? cur_user
  end

  #callback for watch login user on site
  def check_login_user
    redirect_to new_auth_path, notice: 'Sign in for watching.' unless cur_user
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
