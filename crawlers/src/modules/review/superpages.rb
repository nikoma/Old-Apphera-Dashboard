require 'chronic'

module Superpages

  def do_page page
    page.search('div.reviewContainer:not([id]) > div#reviewContent').each do |div|
      item = {}
      item[:reviewer_name] = div.at('div#reviewBy').text.gsub(/\bby /, '').strip
      # item[:title] = 
      # item[:reviewer_image_url] = 
      item[:date] = Chronic.parse(div.at('div#reviewDate').text)
      item[:rating] = div.at('img[name="stars"]')[:alt][/\d/]
      item[:description] = div.at('span.description').text
      if item[:description]['(More)']
        item[:description] = div.at('span.description + span').text.gsub(/\s*.?\(Hide\)/, '')
      end

      item[:id] = URI.decode(div.to_s[/reviewid=([^&"']*)/, 1])
      item[:reviewer_url] = div.at('div#reviewBy a')[:href] rescue nil
      @job.save item
    end
  end

  def scrape url
    page = get url
    company = {}

    company[:name] = page.at('div[id^="coreBizName"] > h1').text
    company[:street] = page.at('meta[property="og:street-address"]')[:content]
    # company[:street2] = 
    company[:postalcode] = page.at('meta[property="og:postal-code"]')[:content]
    company[:city] = page.at('meta[property="og:locality"]')[:content]
    company[:state] = page.at('meta[property="og:region"]')[:content]
    company[:phone1] = page.at('span.BPmainPhone').text.strip
    # company[:phone2] = 
    company[:url] = page.at('span#coreBizWebsite > a').text.strip rescue nil
    company[:latitude] = page.at('meta[property="og:latitude"]')[:content]
    company[:longitude] = page.at('meta[property="og:longitude"]')[:content]
    company[:category] = page.at('h3[text()*="Category"] ~ a[type="content"]')[:name] rescue nil

    @job.save_company company
    do_page page
    while next_link = page.at('a[text()^="Next"]')
      url = URI.decode(next_link[:href][/'([^']*)'/, 1].tr("\n",''))
      page = get url
      do_page page
    end
  end
end

if __FILE__ == $0
  require 'pry'
  require_relative '../../scraper'
  job = Job.new('{"content_provider":"superpages", "module_type":"review", "url":"http://www.superpages.com/bp/San-Diego-CA/Oggis-Pizza-Beverage-Company-L0113594019.htm"}')
  Scraper.new(job).run
end
