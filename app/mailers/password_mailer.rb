class PasswordMailer < ApplicationMailer
  def reset_password(token, user)
    @user = user
    mail(to: @user.email, subject: 'Reset Password')
  end

  def reset_email(token, user)
    @user = user
    mail(to: @user.unconfirmed_email, subject: 'Reset Email')
  end

end
