class ReviewersController < InheritedResources::Base
  before_filter :authenticate_user!
  before_filter :set_org

  # GET /reviews
  # GET /reviews.json
  def index

    unless @org
      redirect_to new_account_path, :notice => t(:please_add_location) and return
    end
    # puts @org.to_json
    # begin
    #       reviews = @org.reviews
    #     rescue
    #     end
    # 
    #     unless reviews.nil?
    #       @reviewers = []
    #       reviews.each do |re|
    #         @reviewers << re.reviewer
    #       end
    @cps = ContentProvider.all.index_by(&:id)
    comps = @org.organizations#.includes(:reviewers)
    reviewer_ids = comps.map { |o| o.list_of_reviewers }.flatten
    @reviewers = Reviewer.find(reviewer_ids)
    #@reviewers = @org.organizations.map { |o| o.reviewers}
    # @reviewers= @reviewers.include(:reviews).sort do |a,b|
    #       a.reviews.size <=> b.review.size
    #     end
    @reviewers = Kaminari.paginate_array(@reviewers).page(params[:page]).per(20)
    # @h = LazyHighCharts::HighChart.new('graph') do |f|
    #        f.options[:legend][:align] = "right"
    #        f.options[:chart][:defaultSeriesType] = "bar"
    #        f.options[:title][:text] = "Anzahl von Reviews"
    #        @reviewers.each do |rev|
    #          f.series(:name => rev.name, :data => [rev.review_count])
    #        end
    #      end


    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reviewers }
    end
  end

  def index2

    unless @org
      redirect_to new_account_path, :notice => t(:please_add_location) and return
    end


    @reviewers = @org.organizations.map { |o| o.reviewers.includes(:reviews) }.flatten

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reviewers }
    end
  end

  # GET /reviewer/1
  # GET /reviewer/1.json
  def show
    @cps = ContentProvider.all.index_by(&:id)

    @reviewer = Reviewer.find(params[:id])
    @reviews = @reviewer.reviews.includes(:organization)
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @reviews }
    end
  end

  # GET /reviews/new
  # GET /reviews/new.json


end
