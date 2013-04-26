class ReportsController < ApplicationController
  def index
    @agg_results = AggregateResult.order("created_at DESC").limit(20)
  end

  def show
  end
end
