class OrderMailer < ApplicationMailer

  def order_delivered(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end

end
