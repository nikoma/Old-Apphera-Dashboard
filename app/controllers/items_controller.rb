class ItemsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :set_org
  def index
    if params[:folder].nil?
      @items = Item.order('created_at DESC')
    else
      @items = Item.where(folder:params[:folder]).order('created_at DESC')
    end    

  end


    def update

    @item = Item.find(params[:id])

    respond_to do |format|
      if @item.update_attributes(params[:item])
        format.json {render :text=>"true"}
      else
        format.html { render action: "edit" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end


end
