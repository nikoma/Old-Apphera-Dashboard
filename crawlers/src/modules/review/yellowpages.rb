require 'chronic'

module Yellowpages

  def do_page page
    page.search('ul#reviews-list > li').each do |div|
      item = {}
      item[:reviewer_name] = div.at('p.review-byline strong a').text.strip
      item[:title] = div.at('h4').text.strip
      # item[:reviewer_image_url] = 
      item[:date] = Chronic.parse(div.at('p.review-byline strong').next.text.strip) 
      item[:rating] = div.at('span[class^="rating-"]')[:class][/\d/]
      item[:description] = div.at('p.review-text').text.strip
      item[:id] = div.at('a.report-abuse')[:href][/\/([^\/]*)\/report_abuse/, 1]
      item[:reviewer_url] = URI.join(@job.url, div.at('p.review-byline strong a')[:href]).to_s
      
      @job.save item
    end
  end

  def scrape url
    page = get url
    company = {}

    company[:name] = page.at('h1.org a').text
    company[:street] = page.at('span.street-address').text.strip
    # company[:street2] = 
    company[:postalcode] = page.at('span.postal-code').text
    company[:city] = page.at('span.locality').text
    company[:state] = page.at('span.region').text

    company[:phone1] = page.at('p.tel strong').text
    # company[:phone2] = 
    company[:url] = page.at('a.primary-website')[:href]

    company[:latitude] = page.at('span#map-latitude').text
    company[:longitude] = page.at('span#map-longitude').text
    company[:category] = page.at('div.back-to-link a:last').text

    @job.save_company company
    do_page page
  end
end

if __FILE__ == $0
  require 'pry'
  require_relative '../../scraper'
  job = Job.new('{"content_provider":"yellowpages", "module_type":"review", "url":"http://www.yellowpages.com/san-diego-ca/mip/94th-aero-squadron-17218353"}')
  Scraper.new(job).run
end
