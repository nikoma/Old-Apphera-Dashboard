class MyCompetitorsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :set_org

  def new
    @new_organization = MyCompetitor.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @my_competitor }
    end
  end

  def create
    @no = MyCompetitor.new(params[:my_competitor])
    @no.organization_id = @org.id

    if @no.save
      respond_to do |format|
        format.html { redirect_to organizations_url, notice: 'Vielen Dank! Bitte erlauben Sie bis zu 24 Stunden bis wir den Mitbewerber eingepflegt haben' }
      end
    else
      # This line overrides the default rendering behavior, which
      # would have been to render the "create" view.
      render :action => "new"
    end
  end


end
