class ProviderSlugsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :set_org
  # GET /provider_slugs
  # GET /provider_slugs.json
  def index
    @provider_slugs = ProviderSlug.where(organization_id: @org.id)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @provider_slugs }
    end
  end

  # GET /provider_slugs/1
  # GET /provider_slugs/1.json
  def show
    @provider_slug = ProviderSlug.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @provider_slug }
    end
  end

  # GET /provider_slugs/new
  # GET /provider_slugs/new.json
  def new
    @provider_slug = ProviderSlug.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @provider_slug }
    end
  end

  # GET /provider_slugs/1/edit
  def edit
    @provider_slug = ProviderSlug.find(params[:id])
  end

  # POST /provider_slugs
  # POST /provider_slugs.json
  def create
    @provider_slug = ProviderSlug.new(params[:provider_slug])
    @provider_slug.organization_id = @org.id
    @provider_slug.bad = false
    respond_to do |format|
      if @provider_slug.save
        format.html { redirect_to @provider_slug, notice: 'Provider slug was successfully created.' }
        format.json { render json: @provider_slug, status: :created, location: @provider_slug }
      else
        format.html { render action: "new" }
        format.json { render json: @provider_slug.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /provider_slugs/1
  # PUT /provider_slugs/1.json
  def update
    @provider_slug = ProviderSlug.find(params[:id])
    @provider_slug.organization_id = @org.id
    @provider_slug.bad = false
    respond_to do |format|
      if @provider_slug.update_attributes(params[:provider_slug])
        format.html { redirect_to @provider_slug, notice: 'Provider slug was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @provider_slug.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /provider_slugs/1
  # DELETE /provider_slugs/1.json
  def destroy
    @provider_slug = ProviderSlug.find(params[:id])
    @provider_slug.destroy

    respond_to do |format|
      format.html { redirect_to provider_slugs_url }
      format.json { head :no_content }
    end
  end
end
