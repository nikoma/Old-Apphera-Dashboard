class FoursquareVenue < ActiveRecord::Base
  attr_accessible :organization_id, :name, :foursquare_id, :phone, :category, :top_category, :address, :city, :postalcode, :state, :lat, :lng

  belongs_to :organization, :foreign_key => "organization_id", :primary_key => "id"
  has_many :foursquare_counts
end
