class UsersController < ApplicationController
  def home_page
  end

  def sign_in
    @user = User.new
  end

  def login
     #debugger
    authorized_user = User.authenticate(params[:user][:username],params[:user][:password])
      if authorized_user
         session[:user_id] = authorized_user.id
         flash[:notice] = "Wow Welcome again, you logged in as #{authorized_user.username}"
         redirect_to :action => 'home_page'
      else
        flash[:error] = "Invalid Username or Password"
        redirect_to :action => 'login'
      end
   end

 def new_user
  @user = User.new
 end

 def register
  @user = User.new(user_params)
  if @user.valid?
    @user.save
    UserMailer.welcome_email(@user).deliver
    session[:user_id] = @user.id
    flash[:notice] = 'Welcome.'
    redirect_to :root
  else
    render :action => "new_user"
  end
 end

 def signed_out
  session[:user_id] = nil
  flash[:notice] = "You have been signed out."
 end

 def forgot_password
    @user = User.new
 end

 def send_password_reset_instructions
   username_or_email = params[:user][:username]

  if username_or_email.rindex('@')
    user = User.find_by_email(username_or_email)
  else
    user = User.find_by_username(username_or_email)
  end

  if user
    user.password_reset_token = SecureRandom.urlsafe_base64
    user.password_expires_after = 24.hours.from_now
    user.save
    UserMailer.reset_password_email(user).deliver
    flash[:notice] = 'Password instructions have been mailed to you. Please check your inbox.'
    redirect_to :sign_in
  else
    @user = User.new
    @user.username = params[:user][:username]
    flash[:error] = 'is not a registered user.'
    render :action => "forgot_password"
  end
 end

 def password_reset
   token = params[:token]
   @user = User.find_by_password_reset_token(token)

  if @user.nil?
    flash[:error] = 'You have not requested a password reset.'
    redirect_to :root
    return
  end

  if @user.password_expires_after < DateTime.now
    clear_password_reset(@user)
    @user.save
    flash[:error] = 'Password reset has expired. Please request a new password reset.'
    redirect_to :forgot_password
  end

 end

 def new_password
  username = params[:user][:username]
  @user = User.find_by_username(username)

  if verify_new_password(params[:user])
    @user.update(params[:user])
    @user.password = @user.new_password

    if @user.valid?
      clear_password_reset(@user)
      @user.save
      flash[:notice] = 'Your password has been reset. Please sign in with your new password.'
      redirect_to :sign_in
    else
      render :action => "password_reset"
    end
  else
    @user.errors[:new_password] = 'Cannot be blank and must match the password verification.'
    render :action => "password_reset"
  end
 end

 private
  def user_params
    params.require(:user).permit(:username, :email, :image, :password, :password_confirmation)
  end
  
end
