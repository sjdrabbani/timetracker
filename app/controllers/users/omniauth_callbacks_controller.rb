class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_action :restrict_access

  def google_oauth2
    if request.env["omniauth.auth"][:info][:email].split('@').last == "nascenia.com" || request.env["omniauth.auth"][:info][:email].split('@').last == "bdipo.com"
      @user = User.find_for_google_oauth2(request.env["omniauth.auth"])
      if @user.persisted?
        flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
        sign_in_and_redirect @user, :event => :authentication
      else
        session["devise.google_data"] = request.env["omniauth.auth"]
        redirect_to new_user_registration_url and return
      end
    else
      flash[:notice] = "Email domain must be either 'nascenia.com' or 'bdipo.com'."
      redirect_to root_path
    end
  end

  def restrict_access
    @user = User.find_for_google_oauth2(request.env["omniauth.auth"])
    logger.info "IP: #{request.remote_ip}"
    if @user.email == 'khalid@nascenia.com' && request.remote_ip != '192.168.1.10'
      flash[:notice] = "Access denied!"
      redirect_to root_path
    end
  end
end