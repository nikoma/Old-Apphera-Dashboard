class UptimeMonitor < ActiveRecord::Base
  attr_accessible :load_time, :organization_id, :time_stamp, :url
  belongs_to :organization
end
