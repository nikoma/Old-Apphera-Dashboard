class TwitterUrl < ActiveRecord::Base
  has_and_belongs_to_many :organizations
  validates_uniqueness_of :url
  has_many :twitter_counts
end
