# Preview all emails at http://localhost:3000/rails/mailers/password_mailer
class PasswordMailerPreview < ActionMailer::Preview
  def password
    PasswordMailer.reset_password('token', User.last)
  end
  def email
    PasswordMailer.reset_email('token', User.last)
  end
end
