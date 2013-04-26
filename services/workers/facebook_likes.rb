require "share_counts"
require 'resque'

class FacebookLikes
  @queue = :facebook_likes
  def self.perform(org_id)
    @org_id = org_id
    org = Organization.find(@org_id)
    likes = ShareCounts.facebook("#{org.url.to_s}" )
    like = Like.new(:count => likes.to_i, :organization_id => @org_id)
    like.save
  end
end
