class SchedulesApiController < ApplicationController

  before_filter :basic_auth

  def index


    @queue = []
    @queue = WorkQueue.where(:queue_name => params[:queue], :invisible => false).first
    @queue.invisible = true if @queue rescue nil
    @queue.save rescue nil
    render json: @queue
  end

  def destroy
    remove_id = params[:id]
    if remove_id
      WorkQueue.delete(remove_id.to_i)

    end
    render :nothing => true, :status => 200, :content_type => 'text/html'
  end

  #def new
  #
  #  q = WorkQueue.create(:queue_name => params[:name], )
  #end

end