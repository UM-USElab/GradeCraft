class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.reset_password_email.subject
  #
  def reset_password_email(user)
  @user = user
  @url  = "http://0.0.0.0:3000/password_resets/#{user.reset_password_token}/edit"
  mail(:to => user.email,
       :subject => "Your password has been reset")
end
end
