class UserMailer < ActionMailer::Base
  default from: "cory@corykaufman.local"

  def reset_password_email(user)
    @user = user
    mail(:to => user.email, :subject => "Your password has been reset")
  end

end
