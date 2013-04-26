module Wowarstdu

  def do_page page
    page.search('div#hotelbewertungenDiv > div > div[@onclick]').each do |div|
      item = {}
      item[:reviewer_name] = div.at('h3 span').text.gsub(/.*bewertet von /,'')
      item[:title] = div.at('h3 u').text.strip
      item[:reviewer_image_url] = URI.join(@job.url, div.at('td[@style]')[:style][/'([^']*)'/, 1]).to_s
      item[:date] =  Date.new($2.to_i, Scraper::MONTHS[:de].index($1)) if div.search('div.info').last.text =~ /(\w+) (\d{4})/
      item[:rating] = 6 - div.at('b').text[/\d/].to_i
      item[:description] = div.at('td[2]').children[2].text.strip
      item[:id] = div.at('a')[:href][/\d+/]
      if item[:description] =~ /...$/
        # get expanded description
        url = URI.join(@job.url, div.at('a')[:href]).to_s
        page = get url
        item[:description] = page.at('//h3[.="Empfehlungen und Infos:"]').next.next.text.strip
      end
      # item[:reviewer_url] = 
      @job.save item
    end
  end

  def scrape url
    page = get url
    company = {}
    company['name'] = page.at('h1').text.strip
    # company['street'] = 
    # company['zip'] = 
    company['city'] = page.at('//td[.="Region:"]').next.next.text.strip
    # company['phone'] = 
    # company['url'] = 
    @job.save_company company
    do_page page
  end
end

#if __FILE__ == $0
#  require 'pry'
#  require_relative '../../scraper'
#  job = Job.new('{"content_provider":"wowarstdu", "module_type":"review", "url":"http://www.wowarstdu.de/hotelbewertungen/bewertungen-anzeigen/hotelId/7091_Park-Inn-by-Radisson-Berlin-Alexanderplatz_Deutschland_Berlin_Berlin"}')
#  Scraper.new(job).run
#end
