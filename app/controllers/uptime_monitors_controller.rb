class UptimeMonitorsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :set_org
  # GET /uptime_monitors
  # GET /uptime_monitors.json
  def index
    @uptime_monitors = @org.uptime_monitors
    unless @uptime_monitors.nil?
      @h = LazyHighCharts::HighChart.new('graph') do |f|
        f.options[:legend][:enabled] = false
        f.options[:chart][:defaultSeriesType] = "column"
        f.options[:title][:text] = "Website Performance"
        # f.options[:xAxis][:categories] = ["Review Bewertungen"]
        # f.series(:name => 'Website Status', :data => [@uptime_monitors])
        @uptime_monitors.each do |agg|
          f.series(:name => agg.url, :data => [agg.load_time])
        end
      end
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @uptime_monitors }
    end
  end

  # GET /uptime_monitors/1
  # GET /uptime_monitors/1.json
  # def show
  #     @uptime_monitor = UptimeMonitor.find(params[:id])
  # 
  #     respond_to do |format|
  #       format.html # show.html.erb
  #       format.json { render json: @uptime_monitor }
  #     end
  #   end


end
