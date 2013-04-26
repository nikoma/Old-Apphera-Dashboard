class ReviewsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :set_org

  # GET /reviews
  # GET /reviews.json
  def index
    unless @org
      redirect_to new_account_path, :notice => t(:please_add_location) and return
    end
    if params[:query].present?
      @reviews = Review.text_search(params[:query], @org.id).order('review_date DESC').includes(:reviewer).page params[:page]#.page(params[:page]).per_page(3)
    else
      @reviews = Review.all_reviews(params[:query], @org.id).order('review_date DESC').includes(:reviewer).page(params[:page]).per(10)
    end
    @cps = ContentProvider.all.index_by(&:id)

    #begin
    #  if params[:query].present?
    #     # @reviews = Review.where(:organization_id => @org.id)
    #      q = params[:query]
    #      p = params[:page] || 1
    #      @reviews = Review.search(q, @org.id, p)
    #     # @reviews = @reviews.includes(:organization, :content_provider, :reviewer)
    #       #@org.reviews.includes(:organization, :content_provider, :reviewer).search(params[:query], load: true)
    #    else
    #     @reviews = @org.reviews.includes(:organization, :content_provider, :reviewer).order('review_date DESC') #{.page params[:page]}
    #end
    #rescue
    #
    #end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reviews }
    end
  end

  def index2
    unless @org
      redirect_to new_account_path, :notice => t(:please_add_location) and return
    end
    if params[:query].present?
      @reviews = Review.search(params, @org.id)
    else
      @reviews = Review.all_reviews(@org.id)
    end

    #begin
    #  if params[:query].present?
    #      @reviews = Review.where(:organization_id => @org.id)
    #      q = params[:query]
    #      p = params[:page] || 1
    #      @reviews = Review.search(q, @org.id)
    #      @reviews = @reviews.includes(:organization, :content_provider, :reviewer)
    #      @org.reviews.includes(:organization, :content_provider, :reviewer).search(params[:query], load: true)
    #    else
    #     @reviews = @org.reviews.includes(:organization, :content_provider, :reviewer).order('review_date DESC') #{.page params[:page]}
    #end
    #rescue
    ##
    #end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reviews }
    end
  end


  def show
    unless @org
      redirect_to new_account_path, :notice => t(:please_add_location) and return
    end
    @cps = ContentProvider.all.index_by(&:id)

    org_id = params[:id]
    @comp_name = Organization.find_by_id(org_id).name

    if params[:query].present?
      @reviews = Review.search(params, org_id).page(params[:page]).per(10)
    else
      @reviews = Review.all_reviews(params, org_id).page(params[:page]).per(10)
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @reviews }
    end
  end

end
