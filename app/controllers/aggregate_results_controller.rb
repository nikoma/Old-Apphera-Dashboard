class AggregateResultsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :set_org
  caches_page :index

  # GET /aggregate_results
  # GET /aggregate_results.json
  def index
    unless @org
      redirect_to new_account_path, :notice => 'Bitte fuegen Sie eine Niederlassung oder Filiale hinzu.' and return
    end

    org = @org
    org = current_user.account.organizations.first unless @org

    #Resque.enqueue(Aggregate,org.id)

    begin
      @aggregate_result = org.aggregate_results.last
      @aggregate_results2 = []
    rescue
    end
    begin
      comps = org.organizations(:include => [:organizations])
    rescue
    end

    unless comps.nil?
      comps.each do |c|
        begin
          res = c.aggregate_results.last
          if res.reviews != 0
            @aggregate_results2 << res
          end
        rescue
        end
      end
      @avg_rating = 0

      @aggregate_count = @aggregate_results2.count
      @aggregate_results2.each do |a|
        begin

          @avg_rating += a.review_avg/@aggregate_count
        rescue

        end
      end
      @avg_rating = sprintf("%.2f", @avg_rating)
      # unless @aggregate_result.nil?
      #         @h = LazyHighCharts::HighChart.new('graph') do |f|
      #           f.options[:legend][:align] = "right"
      #           f.options[:chart][:defaultSeriesType] = "column"
      #           f.options[:title][:text] = "Review Trend"
      #           f.options[:xAxis][:categories] = ["Review Bewertungen"]
      #           f.series(:name => 'Mein Unternehmen', :data => [@aggregate_result.review_avg])
      #           @aggregate_results2.each do |agg|
      #             f.series(:name => agg.organization.name, :data => [agg.review_avg])
      #           end
      #         end


      #end
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @aggregate_results }
    end
  end

  # GET /aggregate_results/1
  # GET /aggregate_results/1.json
  def show
    @aggregate_result = AggregateResult.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @aggregate_result }
    end
  end

  # GET /aggregate_results/new
  # GET /aggregate_results/new.json


  # PUT /aggregate_results/1
  # PUT /aggregate_results/1.json

end
