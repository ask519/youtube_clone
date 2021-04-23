class UserMailer < ApplicationMailer

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: "Welcome to YouTube Clone!")
  end

  def upload_successful(user, video)
    @user = user
    @video = video
    mail(to: @user.email, subject: "Your upload was successful")
  end
end
