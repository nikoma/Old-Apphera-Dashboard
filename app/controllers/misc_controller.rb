class MiscController < ApplicationController
  before_filter :authenticate_user!
  before_filter :set_org

  def index
    @links = @org.organization_links

  end


end