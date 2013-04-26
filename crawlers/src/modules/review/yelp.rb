require 'chronic'

module Yelp

  def do_page page
    page.search('li.review').each do |li|
      item = {}
      item[:id] = li[:id].gsub(/^review_/, '')
      item[:title] = '' # no title
      item[:rating] = li.at('div[itemprop="reviewRating"] img')[:alt][/[\d.]+/]
      item[:description] = li.at('p[itemprop="description"]').text.strip
      item[:date] = Chronic.parse li.at('meta[itemprop="datePublished"]')[:content]
      item[:reviewer_name] = li.at('span[itemprop="author"]').text
      item[:reviewer_url] = URI.join(@job.url, li.at('li.user-name a')[:href]).to_s rescue nil
      item[:reviewer_image_url] = URI.join(@job.url, li.at('img.photo-img')[:src]).to_s rescue nil

      @job.save item
    end
  end

  def scrape url
    page = get url
    company = {}

    company[:name] = page.at('h1[itemprop="name"]').text.strip
    company[:street] = page.at('span[itemprop="streetAddress"]').text.strip
    company[:street2] = 
    company[:postalcode] = page.at('span[itemprop="postalCode"]').text.strip
    company[:city] = page.at('span[itemprop="addressLocality"]').text.strip
    company[:state] = 
    company[:phone1] = page.at('span[itemprop="telephone"]').text.strip
    company[:phone2] = 
    company[:url] = page.at('meta[property="og:url"]')[:content]
    company[:latitude] = page.at('meta[property="place:location:latitude"]')[:content]
    company[:longitude] = page.at('meta[property="place:location:longitude"]')[:content]
    company[:category] = page.at('span#cat_display a:last').text.strip

    @job.save_company company

    do_page page

    # paging
    page.search('div#paginationControls a').select{|a| a.text[/^ ?\d+$/]}.map{|a| URI.join(@job.url, a[:href]).to_s}.each do |url|
      page = get url
      do_page page
    end
  end
end

if __FILE__ == $0
  require 'pry'
  require_relative '../../scraper'
  job = Job.new('{"content_provider":"yelp", "module_type":"review", "url":"http://www.yelp.de/biz/shin-shin-hamburg"}')
  #job = Job.new('{"content_provider":"yelp", "module_type":"review", "url":"http://www.yelp.com/biz/berkeley-pizza-san-diego"}')
  Scraper.new(job).run
end
