class ResellersController < ApplicationController
  def new
    @reseller = Reseller.new
  end

  def create
    @reseller = Reseller.new(params[:reseller])
    if @reseller.save

      redirect_to :root

    else
      # This line overrides the default rendering behavior, which
      # would have been to render the "create" view.
      render :action => "new"
    end
  end

  def setscope
    org_id = params[:organization]
    cookies[:chosen_org] = org_id[:id]
    redirect_to :back

  end

  def show
    @user = User.new
    @reseller
    respond_to do |format|
      format.html
    end

  end
end
