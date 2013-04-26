require 'chronic'

module Mojopages

  def do_page page
    page.search('div[id^=review]:not([id=reviewLoader])').each do |div|
      item = {}
      item[:reviewer_name] = div.at('h4 a').text rescue nil
      item[:reviewer_name] ||= div.at('h4').text.strip
      item[:title] = div.at('div#feed_review_title strong').text
      item[:reviewer_image_url] = div.at('img.userThumbMed')[:src] rescue nil
      item[:reviewer_image_url] ||= 'http://cache.mojopages.com/images/user/userDefault.gif'
      item[:date] =  Chronic.parse div.at('div.feed_dtreviewed').text
      item[:rating] = (div.at('div.ratingBarStarsFull')[:style][/\d+/].to_f / 20) rescue nil
      item[:description] = div.at('div.feed_description').text
      item[:id] = div[:id][/\d+/]
      item[:reviewer_url] = URI.join(@job.url, div.at('h4 a')[:href]).to_s rescue nil
      @job.save item
    end
  end

  def scrape url
    page = get url
    company = {}

    raise 'bad title' unless page.title[/(.*) - .*\d{5} (.*)/]
    company[:name] = $1
    company[:category] = $2
    company[:street] = page.at('meta[property="og:street-address"]')[:content]
    # company[:street2] = 
    company[:postalcode] = page.at('meta[property="og:postal-code"]')[:content]
    company[:city] = page.at('meta[property="og:locality"]')[:content]
    company[:state] = page.at('meta[property="og:region"]')[:content]
    company[:phone1] = page.at('span[id^=phone]').text
    # company[:phone2] = 
    company[:url] = page.at('meta[property="og:url"]')[:content]
    company[:latitude] = page.at('meta[property="og:latitude"]')[:content]
    company[:longitude] = page.at('meta[property="og:longitude"]')[:content]

    @job.save_company company

    do_page page
    while next_link = page.at('a[text()="Next"]')
      url = URI.join(@job.url, next_link[:href]).to_s
      page = get url
      do_page page
    end
  end
end

if __FILE__ == $0
  require 'pry'
  require_relative '../../scraper'
  job = Job.new('{"content_provider":"mojopages", "module_type":"review", "url":"http://www.mojopages.com/biz/pizzeria-luigi/san-diego/ca/92102/11145056"}')
  Scraper.new(job).run
end
