require 'chronic'

module Urbanspoon



  def do_page page
    if more_link = page.at('a#more_comments')[:onclick][/'([^']*)'/, 1]
      url = URI.join(@job.url, more_link).to_s
      page = get url
    end

    page.search('li.comment.row').each do |li|
      item = {}
      item[:reviewer_name] = li.at('div.byline a').text
      item[:title] = li.at('div.title').text.strip
      item[:reviewer_image_url] = li.at('img.user_image')[:srcd]
      item[:date] = Chronic.parse(li.at('div.date').text.strip)
      item[:rating] = (li.at('div.score').text[/doesn't/i] ? '1' : '5') rescue nil
      item[:description] = li.at('div.body').text.strip
      item[:id] = li[:id]
      item[:reviewer_url] = URI.join(@job.url, li.at('div.byline a')[:href]).to_s
      @job.save item
    end
  end

  def scrape url
    page = get url
    company = {}

    company[:name] = page.at('meta[property="og:title"]')[:content]
    company[:street], company[:street2] = page.at('span.street-address').text.strip.split("\n")
    
    company[:postalcode] = page.at('a.postal-code').text
    company[:city] = page.at('span.locality').text
    company[:state] = page.at('span.region').text
    company[:phone1] = page.at('h3.tel').text
    # company[:phone2] = page.at('meta[property=""]')[:content]
    company[:url] = page.at('p.website a')[:href]
    company[:latitude] = page.at('meta[property="urbanspoon:location:latitude"]')[:content]
    company[:longitude] = page.at('meta[property="urbanspoon:location:longitude"]')[:content]
    company[:category] = 'Restaurants'

    @job.save_company company
    do_page page
  end
end

if __FILE__ == $0
  require 'pry'
  require_relative '../../scraper'
  job = Job.new('{"content_provider":"urbanspoon", "module_type":"review", "url":"http://www.urbanspoon.com/r/27/312121/restaurant/Hillcrest/Hash-House-a-Go-Go-San-Diego"}')
  Scraper.new(job).run
end
