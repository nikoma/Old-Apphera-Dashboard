module Golocal
  def do_page page
    page.search('article.review_item').each do |div|
      item = {}
      item[:id] = div[:id]
      item[:date] = Date.parse div.at('meta[@itemprop="dateCreated"]')[:content][/[^ ]+/]
      item[:rating] = div.at('div[@itemprop="ratingValue"]').text
      item[:description] = div.at('div[@itemprop="reviewBody"]').text.strip
      item[:reviewer_name] = div.at('a.bold').text
      item[:reviewer_url] = div.at('a.bold')[:href]
      item[:reviewer_image_url] = div.at('img[@itemprop="image"]')[:src]
      # item[:title] = 
      @job.save item
    end
  end

  def scrape url
    page = get url
    company = {}
    company['name'] = page.at('h1#cmpnme').text.strip
    company['street'] = page.at('span[@itemprop="streetAddress"]').text
    company['zip'] = page.at('span[@itemprop="postalCode"]').text
    company['city'] = page.at('span[@itemprop="addressLocality"]').text
    company['phone'] = page.at('span[@itemprop="telephone"]').text
    # company['url'] = 
    @job.save_company company
    do_page page

    next_link = page.at('li.forward a')
    while next_link
      next_url = URI.join(@job.url, next_link[:href]).to_s
      page = get next_url
      do_page page
      next_link = page.at('li.forward a')
    end
  end

  def valid? url
    true
  end
end

if __FILE__ == $0
  require 'pry'
  require_relative '../../scraper'
  job = Job.new('{"content_provider":"golocal", "module_type":"review", "url":"http://www.golocal.de/hamburg/krankenhaeuser/asklepios-westklinikum-hamburg-gmbh-7cUyT/"}')
  Scraper.new(job).run
end
