class TwitterUser < ActiveRecord::Base
  validates_uniqueness_of :twitter_id

  has_many :tweets, :primary_key => "twitter_id"
end
