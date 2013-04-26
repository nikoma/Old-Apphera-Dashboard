class HomeController < ApplicationController
  before_filter :authenticate_user!
  before_filter :set_org
  #caches_page :index

  #before_filter :no_cache

  def index
    # unless @org
    #       redirect_to new_account_path, :notice => t(:please_add_location) and return
    #     end

    if @org && current_user
      gon.positive_reviews = @org.aggregate_results.last.positive_reviews rescue 0
      gon.negative_reviews = @org.aggregate_results.last.negative_reviews rescue 0
      gon.neutral_reviews = @org.aggregate_results.last.neutral_reviews rescue 0
      gon.fb_likes_new = @org.aggregate_results.last.fb_likes rescue 0
      gon.followers = @org.aggregate_results.last.followers rescue 0
      gon.fs_checkins = @org.aggregate_results.last.fs_checkins_count rescue 0
      gon.fs_tips = @org.aggregate_results.last.fs_tip_count rescue 0
      gon.reviews = @org.aggregate_results.last.reviews rescue 0
      gon.tweets_new = @org.aggregate_results.last.tweets_new rescue 0

      @tasks = @org.task_results.includes(:task).where("status > ?", 0)
      @server = @org.uptime_monitors.last
      if @org.aggregate_results.nil?
        Schedule.create!(sequence_id: 5, scheduled: "2000-01-01 00:00:00", organization_id: @org.id, name: "aggregate-controller", in_progress: false)
      end
      @aggregate = @org.aggregate_results.last
      render :action => 'index'
    else
      if current_user.account.blank?
        redirect_to new_account_path, :notice => t(:please_add_location) and return
      else
        redirect_to accounts_path, :notice => t(:welcome_back)
      end
    end


    def dashboard

      @recommendations = Recommendation.all
    end

    # def sentiments
    #     conditions = []
    #     conditions << [ "created_at < ?", params[:created_at] ]  if params[:created_at].present?
    #     @sentiments = Tweet.last #where(:created_at => conditions).select([:sentiment, :created_at]).last
    #
    #     if stale?(:etag => @sentiments)
    #          @sentiments = Tweet.select([:sentiment, :created_at]).last
    #          # x = @sentiments.sentiment
    #          #         y = @sentiments.created_at.to_i
    #          #                  @ret = [x,y]
    #          respond_to do |f|
    #            @sentiments.created_at = @sentiments.created_at.to_i
    #            f.json { render :json => @sentiments }
    #          end
    #        end
    #

    def no_cache
      response.headers["Last-Modified"] = Time.now.httpdate
      response.headers["Expires"] = '0'
      response.headers["Pragma"] = "no-cache"
      response.headers["Cache-Control"] = 'no-store, no-cache, must-revalidate, max-age=0, pre-check=0, post-check=0'
    end

  end

  def city_autocomplete
    @query = "#{params[:term]}%".downcase
    @cities = City.where(["lower(name) LIKE ? and country_id = ? ", @query, params[:coutry_id]]).limit(10)
    #@cities.collect! {|item| {:label => item.name, :id => item.id}}
    render :json => @cities.collect! {|item| {:label => item.name, :id => item.id}}
  end

end

 