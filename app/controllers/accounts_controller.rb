class AccountsController < ApplicationController
  before_filter :authenticate_user!
  #caches_page :index

  def update_credit_card
    begin
      customer = Stripe::Customer.create(
          :card => params["credit_card"]["stripe_customer_id"],
          :description => current_user.email
      )

      params["credit_card"]["stripe_customer_id"] = customer.id
      if current_user.credit_card.blank?
        params["credit_card"]["user_id"] = current_user.id
        card = CreditCard.new(params[:credit_card])
        current_user.credit_card = card
      else
        current_user.credit_card.update_attributes(params[:credit_card])
      end
      respond_to do |format|
        format.json { render json: {:status => :ok} }
      end
    rescue => ex
      respond_to do |format|
        format.json { render json: {:status => :failure} }
      end
    end
  end

  def index
    if current_user.account.blank?
      redirect_to new_account_path, :notice => t(:please_add_location) and return
    end
    unless current_user.account.reload
      redirect_to new_account_path, :notice => t(:please_add_location) and return
    end
    @user = current_user
    begin
      @account = @user.account
    rescue
    end
    if @account == nil
      render :action => 'new'
    end
    @organizations = @account.organizations.order("name ASC").includes(:category)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @accounts }
    end
  end

  def new
    @account = Account.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @keyword }
    end
  end

  # GET /keywords/1/edit
  def edit
    user_account = current_user.account
    account = Account.find(params[:id])
    if account == user_account
      @account = account
    end

  end

  def update
    @account = Account.find(params[:id])

    respond_to do |format|
      if @account.update_attributes(params[:account])
        format.html { redirect_to accounts_path, notice: t(:account_change_success) }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /keywords
  # POST /keywords.json
  def create
    user = current_user
    acct = Account.new(params[:account])
    @acct = Account.create!(:name => acct.name, :firstname => acct.firstname, :lastname => acct.lastname, :phone => acct.phone, :country_id => acct.country_id, :account_type_id => 3)
    @acct.users << user

    respond_to do |format|
      if @acct.save
        format.html { redirect_to accounts_url, notice: t(:account_create_success) }
        format.json { render json: @acct, status: :created, location: @acct }
      else
        format.html { render action: "new" }
        format.json { render json: @acct.errors, status: :unprocessable_entity }
      end


    end

  end
end
