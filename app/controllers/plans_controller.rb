class PlansController < InheritedResources::Base
  def index
    @plans = Plan.order("price")
  end
end
