require 'chronic'

module Kudzu

  def do_page page
    page.search('table.profileReviewsBody').each do |div|
      item = {}
      item[:reviewer_name] = div.at('div[style="font-size:13px"]').text.strip.gsub(/by (.*) at.*/, '\1').gsub(/[\r\t\n].*/, '')
      #binding.pry if item[:reviewer_name].length>35
      item[:title] = div.at('div.reviewHeading').text.strip
      item[:reviewer_image_url] = URI.join(@job.url, div.at('img[width="50"]')[:src]).to_s
      item[:date] = Chronic.parse(div.at('br + div[text()*="Posted on"]').text[/\d+\/\d+\/\d+/])
      item[:rating] = div.at('div.rating-newstar')[:class][/\d+/].to_f / 10
      item[:description] = div.at('div.reviewHeading + div').text.strip
      item[:id] = div.at('div[id^="rv"]')[:id]
      item[:reviewer_url] = URI.join(@job.url, div.at('div[style="font-size:13px"] a')[:href]).to_s rescue nil
      @job.save item
    end
  end

  def scrape url
    page = get url
    company = {}

    company[:name] = page.at('h1').text
    company[:street] = page.at('span.street-address').text
    if page.at('div.adr br:last').next.text =~ /(.*), ([A-Z]{2}) (\d{5})/
      company[:postalcode] = $3
      company[:city] = $2
      company[:state] = $1
    end
    # company[:street2] = 
    company[:phone1] = page.at('span.tel').text
    if page.at('div.profileMapBorder img')[:src] =~ /center=([\d.-]+),([\d.-]+)/
      company[:latitude] = $1
      company[:longitude] = $2
    end
    # company[:phone2] = 
    company[:url] = page.at('td[text()="Website:"] ~ td a')[:href] rescue nil
    company[:category] = page.at('a.breadcrumb:last').text

    @job.save_company company
    do_page page
    while next_link = page.at('a[text()$="Next"]')
      url = URI.join(@job.url, next_link[:href]).to_s
      page = get url
      do_page page
    end
  end
end

if __FILE__ == $0
  require 'pry'
  require_relative '../../scraper'
  job = Job.new('{"content_provider":"kudzu", "module_type":"review", "url":"http://www.kudzu.com/m/Geisha-House-1392757/reviews/"}')
  Scraper.new(job).run
end
