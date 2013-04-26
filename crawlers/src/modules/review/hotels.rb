module Hotels

  def do_page page
    page.search("div.review").each do |div|
      item = {}
      item[:rating] = div.at('strong.rating').text
      item[:title] = div.at('q.summary').text.strip.gsub(/^"|"$/, '')
      item[:description] = div.at('blockquote.description').text.strip
      item[:date] = Date.parse div.at('div.dtreviewed span.value-title')['title']
      @job.save item
    end
  end

  def scrape url
    page = get url
    company = {}
    company['name'] = page.at('h1.org strong strong').text.strip rescue nil
    company['street'] = page.at('span.street-address').text.strip.gsub(/,$/, '')
    company['zip'] = page.at('span.postal-code').text[/\d{4,}/] rescue nil
    company['city'] = page.at('span.locality').text.strip.gsub(/,$/, '')
    company['phone'] = page.at('span#hd_property_info_tfn').text[/\d[\d +-]{8,}\d/] rescue nil
    # company['url'] = 
    @job.save_company company
    do_page page

    next_link = page.at('a[@title="Next review page"]')
    while next_link
      next_url = URI.join(@job.url, next_link[:href]).to_s
      page = get next_url
      do_page page
      next_link = page.at('a[@title="Next review page"]')
    end
  end
end

if __FILE__ == $0
  require 'pry'
  require_relative '../../scraper'
  job = Job.new('{"content_provider":"hotels", "module_type":"review", "url":"http://www.hotels.com/ho130297/steigenberger-hotel-hamburg-hamburg-germany/#reviews"}')
  Scraper.new(job).run
end
