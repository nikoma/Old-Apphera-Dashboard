class PagesController < InheritedResources::Base

  def update
    page = Page.find(params[:id])
    page.name = params[:content][:page_name][:value]
    page.body = params[:content][:page_body][:value]
    page.save!
    render text: ""
  end
end
