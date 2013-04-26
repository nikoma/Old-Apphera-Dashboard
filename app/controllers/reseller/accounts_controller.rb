class Reseller::AccountsController < ApplicationController
  before_filter :authenticate_user!
  #caches_page :index

  def index
    @accounts = current_user.resellers.first.accounts(:include => [:organizations])
  end

  def new
    @account = Account.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @account }
    end
  end

  # GET /keywords/1/edit
  def edit
    user_accounts = current_user.resellers.first.accounts
    @account = user_accounts.find(params[:id])

  end

  def show
    @account = current_user.resellers.first.accounts.find(params[:id])
    # need to set cookie to keep scope
    cookies["current_account_id"] = @account.id
    @organizations = @account.organizations
  end

  def update
    user_accounts = current_user.resellers.first.accounts
    @account = user_accounts.find(params[:id])
    respond_to do |format|
      if @account.update_attributes(params[:account])
        format.html { redirect_to reseller_accounts_path, notice: t(:account_change_success) }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    reseller = current_user.resellers.first
    user_accounts = current_user.resellers.first.accounts
    @account = user_accounts.find(params[:id])
    begin
      reseller.accounts.delete(@account)
    rescue
    end
    respond_to do |format|
      format.html { redirect_to reseller_accounts_path }
      format.json { head :ok }
    end

  end

  # POST /keywords
  # POST /keywords.json
  def create
    reseller = current_user.resellers.first
    acct = Account.new(params[:account])

    @acct = Account.create!(:name => acct.name, :firstname => acct.firstname, :lastname => acct.lastname, :phone => acct.phone, :account_type_id => 3)
    reseller.accounts << @acct

    respond_to do |format|
      if @acct.save
        format.html { redirect_to reseller_accounts_url, notice: t(:account_create_success) }
        format.json { render json: @acct, status: :created, location: @acct }
      else
        format.html { render action: "new" }
        format.json { render json: @acct.errors, status: :unprocessable_entity }
      end
    end
  end
end
