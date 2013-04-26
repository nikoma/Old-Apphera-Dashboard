class HistoryItemsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :set_org

  # GET /history_items
  # GET /history_items.json
  def index
    @history_items = @org.history_items.paginate.page params[:page].order('created_at DESC')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @history_items }
    end
  end
end
