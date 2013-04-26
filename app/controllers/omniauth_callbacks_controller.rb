class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def google_oauth2
    save_authentication
  end

  def twitter
    save_authentication
  end

  def facebook
    save_authentication
  end

  private
  def save_authentication
    auth = request.env["omniauth.auth"]
    puts auth.to_json
    # Try to find authentication first
    puts auth['provider'] + ' / '+  auth['uid']
    authentication = Authentication.find_by_provider_and_uid(auth['provider'], auth['uid'])

    if authentication
      # Authentication found, sign the user in.
      flash[:notice] = "Signed in successfully."
      sign_in_and_redirect(:user, authentication.user)
    else
      # Authentication not found, thus a new user.
      user = User.find_by_email(auth['extra']['raw_info']['email'])
      if user
        user.apply_omniauth(auth)
      else
        user = User.new
        user.apply_omniauth(auth)
      end

      if user.save(:validate => false)
        flash[:notice] = "Account created and signed in successfully."
        sign_in_and_redirect(:user, user)
      else
        flash[:error] = "Error while creating a user account. Please try again."
        redirect_to root_url
      end


    end
  end

end