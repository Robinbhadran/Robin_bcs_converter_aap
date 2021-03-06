class Users::SessionsController < Devise::SessionsController
  def google_oauth2
# You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
      sign_in_and_redirect @user, :event => :authentication
    else
      session["devise.google_data"] = request.env["omniauth.auth"]
      session["devise.user_attributes"] = @user.attributes
      redirect_to new_user_registration_url
    end
  end
  def failure
   flash[:notice] = params[:message] # if using sinatra-flash or rack-flash
   flash[:notice] = params[:message]
  redirect_to root_path
  end

end
