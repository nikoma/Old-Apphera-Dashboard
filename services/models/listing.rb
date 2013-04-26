class Listing < ActiveRecord::Base
#  include Tire::Model::Search
#  include Tire::Model::Callbacks
  attr_accessible :city, :content_provider, :name, :organization_id, :phone, :street, :zip
  belongs_to :organization
#  Tire.configure do
#    url Appheradashboard::Application::CONFIG[:tire_ip]
#  end
  
  def self.paginate(options = {})
       page(options[:page]).per(options[:per_page])
  end
  
  
  
  
end
