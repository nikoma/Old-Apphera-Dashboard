#!ruby19
# encoding: utf-8
$LOAD_PATH.unshift File.dirname(__FILE__)

#5. inform user that new results are there if there is a change to the previous result

# accessors: [ :score, :reviews, :review_average, :negative_reviews, :negative_reviews_new, 
# :neutral_reviews, :neutral_reviews_new, :videos, :photos, :tweets, :tweets_new, 
# :fb_likes, :fb_likes_new, :score, :followers, :following ]
require_relative  '../provider'
require 'json'
include Provider
require_relative 'settings'
require 'bunny'

class Aggregate
  include Settings
  b = Bunny.new(:host =>HOST, :user => USER, :pass => PASS)
  b.start
  EXCHANGE = b.exchange("")
  QUEUE = b.queue("aggregate")
  loop do
  #p "Another loop " + Time.new.to_s
    job = JSON.parse(QUEUE.pop[:payload]) rescue nil
  if job
  @organization_id = job["org_id"].to_i
   
    @org = Organization.find(@organization_id)
    @org_list = Organization.where("id = ?", @organization_id)
    @comps = @org.organizations
    @all = (@org_list + @comps)
    @date = Date.today
    @creview_average_num = 0
    @all.each do |o|
      @reviews = 0
      @org_reviews = 0
      @org_reviews_new = 0
      @org_negative_count = 0
      @org_positive_count = 0
      @org_neutral_count = 0
      @review_avg = 0
      @followers = 0
      @following = 0
      @tweets = 0
      @listed = 0
      @fb_likes = 0
      @fb_likes_new = 0
      @fs_checkins_count = 0
      @fs_users_count = 0
      @fs_tip_count = 0
      @foursquare_counts = nil
      fb_page = o.facebookpages.first
      unless fb_page.nil?
      @fb_likes = fb_page.likes
      end
      tw_counts = o.twitter_counts.last
      unless tw_counts.nil?
        @followers = tw_counts.followers
        @following = tw_counts.following
        @listed = tw_counts.listed
        @tweets = tw_counts.tweets
      end
      begin
      @foursquare_counts = o.foursquare_venues.first.foursquare_counts.last
    rescue
    end
      unless @foursquare_counts.nil?
        @fs_checkins_count = @foursquare_counts.checkins_count
        @fs_users_count = @foursquare_counts.users_count
        @fs_tip_count = @foursquare_counts.tip_count
      end
      @reviews = o.reviews
      unless @reviews.nil?

        @org_reviews = @reviews.count
        @org_reviews_new = @reviews.where("review_date < ?", 1.months.ago).count
        @org_negative_count = @reviews.where("rating < 3").count
        @org_negative_new = @reviews.where("rating < 3","review_date < ?", 1.months.ago).count
        @org_positive_count = @reviews.where("rating > 3").count
        @org_positive_new = @reviews.where("rating > 3","review_date < ?", 1.months.ago).count
        @org_neutral_count = @reviews.where("rating = 3").count
        @org_neutral_new = @reviews.where("rating = 3","review_date < ?", 1.months.ago).count


        begin
          @review_avg = sprintf("%.2f", @reviews.average('rating'))
        rescue
        end
        end
        # should start with what I can get QUICK -> yelp and qype reviews and google reviews?
        # @review_avg = sprintf("%.1f",track.ratings.average('rating'))
      begin
        puts "writing for " + o.id.to_s
        AggregateResult.create!(:organization_id => o.id,:fs_users_count => @fs_users_count, :fs_checkins_count => @fs_checkins_count, :fs_tip_count => @fs_tip_count,:followers => @followers, :following => @following,  :negative_reviews_new => @org_negative_new, :neutral_reviews_new => @org_neutral_new,:positive_reviews_new => @org_positive_new,  :negative_reviews => @org_negative_count, :positive_reviews => @org_positive_count, :neutral_reviews => @org_neutral_count, :score => 23, :photos => 0, :videos => 0, :reviews => @org_reviews, :reviews_new => @org_reviews_new, :review_avg => @review_avg, :tweets => @tweets, :tweets_new => 0, :fb_likes => @fb_likes, :fb_likes_new => @fb_likes_new, :mentions => 25, :mentions_new => 4,:listed => @listed, :blog_posts => 234, :blog_posts_new => 15)
        sched = Schedule.where(:organization_id => o.id, :sequence_id => 5).first
        sched.delete
      rescue
      end
end

      #mark sequence as done   !!! todo
   # end
  end
  sleep 1
end
end


