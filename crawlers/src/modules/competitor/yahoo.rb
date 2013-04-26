module Yahoo

  def do_page page
    page.search('ol#results li').each do |div|
      item = {}
      item[:name] = div.at('a.fn').text.strip
      item[:review_url] = URI.join(@job.url, div.at('a.fn')[:href][/[^;]*/]).to_s
      item[:phone] = div.at('h3.tel').text.strip.gsub(/\xC2\xA0/u,' ')
      item[:street] = div.at('p.street-address').text.strip
      item[:zip], item[:city] = $1, $2 if div.at('p.postal-code').text =~ /(\d{5}) (.*)/
      item[:latitude] = div.at('span.latitude').text.strip
      item[:longitude] = div.at('span.longitude').text.strip
      item[:rating] = div.to_s[/read_star_(\d)/,1] rescue nil
      begin
        redirect = @agent.head(div.at('a.url')[:href])
        item[:website] = redirect.header['location'] || redirect.uri.to_s
        # redirect = @agent.head(div.at('a.url')[:href])
        # redirect = @agent.head redirect.header['location'] while redirect.header['location'] =~ /de.wrs.yahoo.com|pub.oy1.oe.wipe.de/        
        # item[:website] = redirect.header['location']# || redirect.uri.to_s
      rescue
      end
      @job.save item
    end
  end

  def scrape url
    page = get(url).forms[0].submit
    do_page page
    company = {}
    do_page page

    next_link = page.at('a[@rel="Next"]')
    a = 0
    while next_link
      a += 1
      next_url = URI.join(@job.url, next_link[:href]).to_s
      page = get next_url
      sleep 0.5
      do_page page
      next_link = page.at('a[@rel="Next"]')
    end
  end
end

if __FILE__ == $0
  require 'pry'
  require_relative '../../scraper'
  job = Job.new('{"content_provider":"yahoo", "module_type":"competitor", "url":"http://de.local.yahoo.com/?search.html?cs=&vid=&p=Restaurant%3A_Italienisch&poi=hamburg&yls-submit=Suche"}')
  Scraper.new(job).run
end
