class OrganizationLink < ActiveRecord::Base

  after_create :extract_slugs

  attr_accessible :bing_display_url, :bing_id, :description, :organization_id, :title, :url
  belongs_to :organization
  validates_uniqueness_of :bing_id

  def extract_slugs
    @cp = {:google_germany => 8, :kennstdueinen => 12, :yelp => 5 ,:tripadvisor => 7, :bing => 6, :pointoo => 13, :qype => 10, :golocal => 14, :hotels => 15, :meinestadt => 16, :restaurantkritik => 17, :wowarstdu => 18}
    @cp_urls = { :kennstdueinen => "www.kennstdueinen.de", :yelp => "www.yelp.de", :tripadvisor => "www.tripadvisor.com", :pointoo => "www.pointoo.de", :qype => "www.qype.com/place", :golocal => "www.golocal.com", :hotels => "hotels.com", :meinestadt => "meinestadt.de", :restaurantkritik => "www.restaurant-kritik.de", :wowarstdu => "wowarstdu.de"}
    @cp_urls.each do |k,v|
           if self.url.include? v
             ProviderSlug.create!(organization_id: self.organization_id, content_provider_id: @cp[k], slug: self.url, bad: false)
           end
      end
  end
end
