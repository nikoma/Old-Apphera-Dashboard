class KeywordsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :set_org

  # GET /keywords
  # GET /keywords.json
  def index
    unless @org
      redirect_to new_account_path, :notice => t(:add_location) and return
    end

    # orgs = @org.account.organizations
    #     unless orgs
    #       orgs = current_user.account.organizations
    #     end
    #     # raise "The organization is " + @org.id.to_s + " " + @org.name
    #     @keywords = []
    #     begin
    #       orgs.each do |o|
    #         kw = o.keywords
    #         kw.each do |kw|
    #           @keywords << kw
    #         end
    #       end
    #     rescue
    #     end
    @keywords = @org.keywords

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @keywords }
    end
  end

  # GET /keywords/1
  # GET /keywords/1.json
  def show
    # > @org = current_user.account.organizations.first
    # >     @keywords = @org.keywords
    # >     @keyword = @keywords.find(params[:id])
    # >     
    # >     @org = current_user.account.organizations.first
    if @org.keywords
      @url = @org.url || "93287d8unhwcfhklwjeh8"
      @keywords = @org.keywords

      kw_id = params[:id]
      s = Ranking.where(keyword_id: kw_id).last

      if s
      @keyword = JSON.parse(s.ranks)
      else
      end

      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @keyword }
      end
    else
      format.html { redirect_to keywords_url, notice: t('unkown_keyword') }

    end

  end

  # GET /keywords/new
  # GET /keywords/new.json
  def new
    @keyword = Keyword.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @keyword }
    end
  end

  # # GET /keywords/1/edit
  #  def edit
  #    @keyword = Keyword.find(params[:id])
  #  end

  # POST /keywords
  # POST /keywords.json
  def create


    kw = Keyword.new(params[:keyword])
    @newkey = Keyword.find_or_create_by_name(:name => kw.name)
    @org.keywords << @newkey

    respond_to do |format|
      if @newkey.save
        # Resque.enqueue(Ranks, @newkey.id, org.id, 8, 5) #keyword_id, organization_id, content_provider_id, attempts
        #        Resque.enqueue(Ranks, @newkey.id, org.id, 9, 5)
        format.html { redirect_to keywords_url, notice: t('keyword_create_success') }
        format.json { render json: @keyword, status: :created, location: @keyword }
      else
        format.html { render action: "new" }
        format.json { render json: @keyword.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /keywords/1
  # PUT /keywords/1.json


  # DELETE /keywords/1
  # DELETE /keywords/1.json
  def destroy
    #org = current_user.account.organizations.first
    @keyword = Keyword.find(params[:id])

    @org.keywords.delete(@keyword)
    respond_to do |format|
      format.html { redirect_to keywords_url }
      format.json { head :ok }
    end
  end
end
