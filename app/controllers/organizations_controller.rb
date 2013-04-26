class OrganizationsController < ApplicationController

  before_filter :authenticate_user!
  before_filter :set_org
  before_filter :set_comps
  # GET /organizations
  # GET /organizations.json
  #caches_page :index
  #autocomplete :city, { :city => [:name, :country_id]}
  def index
    unless @org
      redirect_to new_account_path, :notice => t(:please_add_location) and return
    end
    begin
      @organizations = @comps.order('name ASC').page params[:page]
    rescue
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @organizations }
    end
  end

  def mapview
    @gmap = @comps.to_gmaps4rails do |organization, marker|
      marker.title organization.name
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @organizations }
    end
  end

  def myorgs
    if current_user

      respond_to do |format|

        format.json { render json: @myorgs }
      end
    end
  end

  # GET /organizations/1
  # GET /organizations/1.json
  # def show
  # 
  #     redirect_to accounts_url, :notice => t(:please_add_location) and return
  #   end

  # GET /organizations/new
  # GET /organizations/new.json
  def new
    @cats = (Category.all(:select => "name").collect { |c| c.name }).join(', ')
    @organization = Organization.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @organization }
    end
  end

  # GET /organizations/1/edit
  def edit
    @categories = Category.all(:order => "name ASC")
    organization = Organization.where("id = ?", params[:id]).first
    org_account = organization.account
    user_account = current_user.account
    if org_account == user_account # TODO: need move it to model
      @organization = organization
    end


  end

  # POST /organizations
  # POST /organizations.json
  def create
    @organization = Organization.new(params[:organization])
    @organization.country_code_id = params[:country_code_id].to_i
    @organization.category = Category.where(name: params[:organization][:category_id]).where(country_id: @organization.country_code_id ).first
    existing = @organization.existing?(@organization)
    account = current_user.account
    if existing
      @organization = Organization.find existing
      account.organizations << @organization unless @organization.account
      @organization.save!

        Schedule.create!(organization_id: @organization.id, sequence_id: 6, name: 'new', in_progress: false, scheduled: '2000-01-01 00:00:00')
        Schedule.create!(organization_id: @organization.id, sequence_id: 5, name: 'aggregate', in_progress: false, scheduled: '2000-01-01 00:00:00')

      unless Rails.env.test? or Rails.env.development?
        BingApi.perform_async(@organization.id)
        CompSearch.perform_async(@organization.id)
      end
      respond_to do |format|
        format.js
        format.html { redirect_to root_url, notice: t(:organization_create_success) }
        format.json { render json: {} }
      end
    else
      @organization.account_id = current_user.account_id
      @organization.yahooslug = SecureRandom.urlsafe_base64
      account.organizations << @organization
      puts @organization.errors.full_messages
      @organization.save!

      unless Rails.env.test? or Rails.env.development?
        BingApi.perform_async(@organization.id)
        CompSearch.perform_async(@organization.id)
      end
      respond_to do |format|
        format.js
        format.html { redirect_to root_path, notice: t(:organization_create_success) }
        format.json { render json: {:data => render_to_string(:partial => 'organizations/organization.html.erb', :layout => false, handlers: [:html, :erb],
                                                              :locals => {:organization => @organization})} }
      end
    end
  end


# PUT /organizations/1
# PUT /organizations/1.json
#TODO: secure this!
    def update
      @organization = Organization.find(params[:id])

      respond_to do |format|
        if @organization.update_attributes(params[:organization])

          format.html { redirect_to accounts_path, notice: t(:organization_update_success) }
          format.json { head :ok }
        else
          format.html { render action: "edit" }
          format.json { render json: @organization.errors, status: :unprocessable_entity }
        end
      end
    end

# DELETE /organizations/1
# DELETE /organizations/1.json

    def destroy

      @organization = Organization.find(params[:id])
      #raise "it tries to delete #{params[:id]}"
      # TODO -> if from my account I need to detect that

      @acc = current_user.account.organizations.where("id = ?", @organization.id).first


      if @acc
        @organization.account_id = 0
        @organization.save
      else
        @org.organizations.delete(@organization)
        @org.save
      end

      respond_to do |format|
        format.html { redirect_to (:back) }
        format.json { head :ok }
      end
    end

    def autocomplete_categories
      @query = "#{params[:name]}%".downcase
      @cities = Category.where(["name ilike ? and country_id = ? ", @query, params[:country_code_id]]).limit(30)
      render :json => @cities.collect! { |item| {:label => item.name, :id => item.id} }
    end
  end
