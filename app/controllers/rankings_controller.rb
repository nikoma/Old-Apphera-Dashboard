class RankingsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :set_org
  # GET /rankings
  # GET /rankings.json
  def index

    unless @org
      redirect_to new_account_path, :notice => t(:please_add_location) and return
    end

    begin
      keys = @org.keywords.last
    rescue
    end
    begin
      @rankings = keys.rankings
    rescue
    end
    # ranks = org.rankings
    #      ranks.each do |rank|
    #       @rankings << rank
    #    end 
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @rankings }
    end
  end

  # GET /rankings/1
  # GET /rankings/1.json
  def show
    @ranking = Ranking.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ranking }
    end
  end
end

 
  

