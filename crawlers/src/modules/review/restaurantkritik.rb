module Restaurantkritik

  def do_page page
    page.search('div.wall_entry').each do |div|
      item = {}
      item[:rating] = div.at('div.current-rating')[:title][/[\d.]+/]
      item[:reviewer_image_url] = div.at('img')[:src]
      item[:date] = Date.new *div.at('span').text.split('.').reverse.map(&:to_i)
      item[:reviewer_name] = div.at('div.header a').text.gsub(/ \(\d*\)/, '') rescue nil
      if item[:reviewer_name]
        item[:reviewer_url] = URI.join(@job.url, div.at('div.header a')[:href]).to_s
      else
        item[:reviewer_name] = div.at('div.header > span').text.gsub(/ \(\d*\)/, '')
      end
      item[:id] = div.at('.//a[contains(.,"mehr ")]')[:href][/\d+/]
      item[:description] = div.at('div.content > p').text.strip.gsub(/ mehr .$/, '')

      if item[:description] =~ /...$/
        # get expanded description
        url = URI.join(@job.url, div.at('.//a[contains(.,"mehr ")]')[:href]).to_s
        review = get url
        h3 = review.at('//h3[.="Rezension"]')
        description = h3.parent
        h3.remove
        item[:description] = description.text.strip
      end

      # item[:title] = 
      @job.save item
    end
  end

  def scrape url
    page = get "#{url}/bewertungen"
    company = {}
    company['phone'] = page.at('//td[.="Tel"]').next.next.text
    company['street'] = page.at('p.street-address').text.strip.gsub(/\s+/, ' ')
    company['zip'] = page.at('span.postal-code').text
    company['city'] = page.at('span.locality').text
    company['name'] = page.at('span.fn').text.strip
    company['url'] = page.at('a.bigger[@title]')[:href] rescue nil
    @job.save_company company
    do_page page

    next_link = page.at('a.next_page')
    while next_link
      next_url = URI.join(@job.url, next_link[:href]).to_s
      page = get next_url
      do_page page
      next_link = page.at('a.next_page')
    end
  end

  def valid? url
    url =~ /^http:\/\/www.restaurant-kritik.de\/\d+$/i
  end
end

#if __FILE__ == $0
#  require 'pry'
#  require_relative '../../scraper'
#  job = Job.new('{"content_provider":"restaurantkritik", "module_type":"review", "url":"http://www.restaurant-kritik.de/1724"}')
#  Scraper.new(job).run
#end
