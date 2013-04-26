class ApplicationController < ActionController::Base
  #before_filter :authenticate_user! 
  around_filter :scope_current_reseller
  before_filter :set_locale
  before_filter :set_org

  protect_from_forgery

  # before_filter :set_locale
  def after_sign_in_path_for(resource)
    if current_user.account.nil?
      new_account_path
    else
      params[:current_page] || super
    end
  end


  private

  # def set_locale
  #     I18n.locale = params[:locale] if params[:locale].present?
  #     # request.env["HTTP_ACCEPT_LANGUAGE"]
  #     # current_user.locale
  #     # request.subdomain
  #     
  #     # request.remote_ip
  #   end

  # def default_url_options(options = {})
  #     {locale: I18n.locale}
  #   end

  def signup_complete
    begin
      @account = current_user.account
    rescue
    end
  end

  # def my_orgs
  #     begin
  #       @myorgs = current_user.account.organizations
  #     end
  #   end


  def set_org
    org_id = cookies[:chosen_org].to_i
    begin
      org_id > 0 ? @org = Organization.find(org_id) : @org = current_user.account.organizations.first
      @myorgs = current_user.account.organizations
      @reseller = current_user.account.resellers.first
      @accounts = @reseller.accounts.includes(:organizations)
    rescue
    end

  end

  private


  def current_reseller
      Reseller.find_by_sub_domain(request.subdomain) || Reseller.find_by_sub_domain('front')


  end

  helper_method :current_reseller

def scope_current_reseller
    Reseller.current_id = current_reseller.id
    yield
  ensure
    Reseller.current_id = 1
end

  # def set_locale
  #      I18n.locale = params[:locale] if params[:locale].present?
  #    end
  def set_locale
    I18n.locale = extract_locale_from_tld || I18n.default_locale
  end

  def extract_locale_from_tld
    parsed_locale = request.host.split('.').last
    I18n.available_locales.include?(parsed_locale.to_sym) ? parsed_locale : nil
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == USER_ID && password == PASSWORD
    end
  end

  def set_comps
    begin
      org_id = cookies[:chosen_org].to_i
      @org = Organization.find(org_id) unless org_id.nil?
      @comps = @org.organizations #TODO: scope security - now you could use cookie of someone else
    rescue
    end

    begin
      @comps = current_user.account.organizations.first.organizations unless @comps
    rescue
    end

  end
end
