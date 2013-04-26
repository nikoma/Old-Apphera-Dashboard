class FoursquareVenue < ActiveRecord::Base
  belongs_to :organization , :foreign_key => "organization_id", :primary_key => "id"
  has_many :foursquare_counts
end
