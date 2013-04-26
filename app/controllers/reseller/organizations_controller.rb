class Reseller::OrganizationsController < ApplicationController
  before_filter :authenticate_user!

  def index

  end

  def new
    #TODO: validate that id belongs to reseller
    @account_id = cookies["current_account_id"].to_i
    @categories = Category.all(:order => "name ASC")
    @organization = Organization.new(account_id: @account_id)
  end

  def create

  end

end