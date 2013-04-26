class ExamplesController < ApplicationController
  around_filter :scope_current_reseller
  before_filter :set_locale

  def index
    # @org_count = Organization.count.to_i
    #     gon.watch.org_count = @org_count
    @org_count = Organization.count.to_i
  end

  def network


    ticks = request.query_parameters['_'].to_i
    @counts = rand(43..2942)
    #@ticks = Time.at(ticks/1000)
    @res = {x: ticks, y: @counts}.to_json

    # @tweets = counts.tweets.to_s.reverse.gsub(/...(?=.)/, '\&,').reverse
    #     @twitter_users = counts.twitter_users.to_s.reverse.gsub(/...(?=.)/, '\&,').reverse
    #
    #     @sentiments = NetworkWeather.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @res }
    end


  end

  def bonus
  end

  def charts
  end

  def elements
  end

  def error
  end

  def faq
  end

  def gallery
  end

  def jqueryui
  end

  def login
  end

  def pricing
  end

  def reports
  end

  def settings
  end

  def signup
  end

  def skins
  end

  def sticky
  end

  def validation
  end
end
