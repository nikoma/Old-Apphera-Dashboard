require 'chronic'

module Twitter

  def do_page page
    page.search('table.tweet').each do |table|
      item = {}
      item[:image_url] = table.at('td.avatar a img')[:src]
      item[:date] = Chronic.parse table.at('td.timestamp a').text
      item[:date] = (item[:date].to_date - 365).to_time if item[:date] > Time.now 
      item[:fullname] = table.at('strong.fullname').text
      item[:username] = table.at('span.username').text.strip
      item[:text] = table.at('div.tweet-text').text
      item[:profile_url] = URI.join(@job.url, table.at('td.avatar a')[:href]).to_s

      @job.save item
    end
  end

  def scrape url
    page = get url
    user = {}

    user[:fullname] = page.at('div.fullname').text.strip
    user[:username] = page.at('div.username').text.strip
    user[:location] = page.at('div.location').text.strip
    user[:bio] = page.at('div.bio').text.strip
    user[:url] = page.at('div.url').text.strip
    user[:tweets] = page.at('div[text()="Tweets"]').parent.at('div').text
    user[:following] = page.at('div[text()="Following"]').parent.at('div').text
    user[:followers] = page.at('div[text()="Followers"]').parent.at('div').text

    @job.save_company user

    do_page page

    while next_link = page.at('a[text()="Load older Tweets"]')
      url = URI.join(@job.url, next_link[:href]).to_s
      page = get url
      do_page page
    end
  end
end

if __FILE__ == $0
  require 'pry'
  require_relative '../../scraper'
  job = Job.new('{"content_provider":"twitter", "module_type":"review", "url":"https://mobile.twitter.com/nikolaimanek"}')
  Scraper.new(job).run
end
