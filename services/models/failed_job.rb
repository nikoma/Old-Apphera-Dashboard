class FailedJob < ActiveRecord::Base
  attr_accessible :organization_id, :reason, :retry_count, :schedule_id

end
