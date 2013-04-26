node(:created_at) do
  @agg_results.map { |ag| ag.created_at.to_i*1000 }
end

node(:positive_reviews) do
  @agg_results.map(&:positive_reviews)
end

node(:neutral_reviews) do
  @agg_results.map(&:neutral_reviews)
end

node(:negative_reviews) do
  @agg_results.map(&:negative_reviews)
end

node(:checkins) do
  @agg_results.map do |ar|
    ar.fs_checkins_count || 0
  end
end

node(:events) do
  @agg_results.map(&:negative_reviews)
end

node(:tweets) do
  @agg_results.map(&:tweets)
end

node(:twitter_followers) do
  @agg_results.map(&:followers)
end

node(:facebook_followers) do
  @agg_results.map(&:followers)
end

node(:facebook_likes) do
  @agg_results.map(&:fb_likes)
end
