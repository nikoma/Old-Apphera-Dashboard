module Kennstdueinen
  def scrape url
    page = get(url).parser
    company = {}
    company['name'] = page.at('h1.org').text.strip rescue nil
    company['street'] = page.at('span.street-address').text rescue nil
    company['zip'] = page.at('span.postal-code').text[/\d{4,}/] rescue nil
    company['city'] = page.at('span.locality').text.strip rescue nil
    company['phone'] = page.at('span.tel').text rescue nil
    # company['url'] = page.at('').text ? can't find an url
    @job.save_company company

    page.search(".hreview").each do |r|
      item = {}
      reviewid2 = /(?<=reportReview\/)\d{2,}/im.match(r.to_s) rescue nil
      item[:id] = reviewid2[0].to_s rescue nil
      item[:description] = r.search(".description").text + "\n\n " + r.search(".description").text.strip rescue nil
      reviewdatestring = r.search(".dtreviewed").text rescue nil
      item[:date] = Date.parse(reviewdatestring) rescue nil
      item[:rating] = r.search('.rating').text rescue nil
      item[:reviewer_name] = r.search('.reviewer').text rescue nil
      item[:reviewer_url] = r.search(".reviewer").attribute("href").value rescue nil
      @job.save item
    end
  end
end

# this part helps me test it, it only gets run when we're testing.
# we can comment it out once we're done testing

if __FILE__ == $0
  require 'pry'
  require_relative '../../scraper'
  job = Job.new('{"content_provider":"kennstdueinen", "module_type":"review", "url":"http://www.kennstdueinen.de/zahnarzt-hamburg-aesthetik-zahnarzt-hamburg-city-z-24-d42832.html"}')
  Scraper.new(job).run
end
