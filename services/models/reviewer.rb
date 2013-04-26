class Reviewer < ActiveRecord::Base
  has_many :reviews
  belongs_to :content_provider
  validates_uniqueness_of :slug
end
