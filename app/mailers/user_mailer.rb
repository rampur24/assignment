class UserMailer < ApplicationMailer
 def welcome_email(user)
  @user = user
  @url = 'http://localhost:3000/sign_in'
  @site_name = "localhost"
  mail(:to => user.email, :subject => "Welcome to my website.")
 end

 def reset_password_email(user)
  @user = user
  @password_reset_url = 'http://localhost:3000/password_reset?' + @user.password_reset_token
  mail(:to => user.email, :subject => 'Password Reset Instructions.')
end
def password_reset(user)
  @user = user
  mail :to => user.email, :subject => "Password Reset"
end


def clear_password_reset(user)
  user.password_expires_after = nil
  user.password_reset_token = nil
end

def verify_new_password(passwords)
  result = true

  if passwords[:new_password].blank? || (passwords[:new_password] != passwords[:new_password_confirmation])
    result = false
  end

  result
end
def forgot_password(user)
  @user = user
  @greeting = "Hi"
  
  mail to: user.email, :subject => 'Reset password instructions'
end
end
