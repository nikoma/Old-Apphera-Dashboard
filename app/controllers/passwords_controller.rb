class PasswordsController < Devise::PasswordsController

  def create
    url = "#{request.host}:#{request.port}"
    ActionMailer::Base.default_url_options[:host] = url
    self.resource = resource_class.send_reset_password_instructions(resource_params )
    if successfully_sent?(resource)
      respond_with({}, :location => after_sending_reset_password_instructions_path_for(resource_name))
    else
      respond_with(resource)
    end


  end
  protected
  def after_sending_reset_password_instructions_path_for(resource)
    new_session_path(resource_name)
  end

end
