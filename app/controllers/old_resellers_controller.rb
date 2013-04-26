class OldResellersController < ApplicationController
  before_filter :authenticate_user!

  def setscope
    org_id = params[:organization]
    cookies[:chosen_org] = org_id[:id]
    redirect_to :back

  end

  def index

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def accounts
    @user = current_user
    @accounts = @user.resellers.first.accounts
    respond_to do |format|
      format.json { render json: @accounts }
    end
  end

  def newaccount
    user = current_user
    acct = Account.new(params[:model])

    acct.users << user
    acct.resellers << user.resellers.first
    acct.save()
    respond_to do |format|
      format.json { render json: acct }
    end
  end

  def updateaccount
    model = params[:model]
    acct = Account.find(model[:id])

    acct.update_attributes(model)
    acct.users << current_user
    respond_to do |format|
      format.json { render json: acct }
    end
  end


  def acctorg
    @returnval = Organization.find_all_by_account_id(params[:value])

    respond_to do |format|
      format.json { render json: @returnval }
    end
  end

  def newacctorg

    @organization = Organization.new(params[:model])

    uuid = UUID.new
    @organization.yahooslug = uuid.generate # ad the slug has to be unique I just generate a UUID here and replace later

    if @organization.save
      if @organization.facebook.length > 0
        fb = FacebookUrl.new(:url => @organization.facebook)
        @organization.facebook_urls << fb

      end
      if @organization.twitter.length > 0
        tw = TwitterUrl.new(:url => @organization.twitter)
        @organization.twitter_urls << tw
      end
      #Resque.enqueue(AppheraReverseGeo,@organization.id)  #Geo code new venue - TODO: put in signup automation as we will need it for API calls too.
      @organization.save

      respond_to do |format|
        format.json { render json: @organization }
      end
    end

  end


  def updateacctorg

    model = params[:model]
    editorg = Organization.find(model[:id])

    editorg.update_attributes(model)

    respond_to do |format|
      format.json { render json: editorg }
    end
  end


end