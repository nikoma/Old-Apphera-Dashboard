require 'chronic'

module Google
  def scrape url
    page = get(url).parser
    
    company = {}
    company['name'] = page.at('span.pp-place-title span').text
    company['street'], company['zip'], company['city'] = $1, $2, $3 if page.at('span.pp-headline-address span').text =~ /(.*), (\d{4,}) (.*)/
    company['phone'] = page.at('span.telephone').text
    company['url'] = page.at('span.pp-headline-authority-page span a')[:href][/\?q=([^&]+)/, 1]
    @job.save_company company

    #content provider, name, street, zip, city, url, phone
    page.search('div.pp-story-item').each do |div|
      item = {}
      item[:description] = div.at('span.snippet').text.strip.gsub(/\s+/, ' ') rescue nil
      item[:reviewer_name] = div.at('a').text rescue nil
      item[:reviewer_url] = URI.join(url, div.at('a')[:href]).to_s rescue nil
      item[:reviewer_image_url] = URI.join(url, div.at('img.pp-review-author-photo')[:src]).to_s rescue nil
      item[:rating] = div.css('div.rsw-starred').length rescue nil
      item[:date] = Chronic.parse div.css('span.date').last.text
      item[:title] = nil
      item[:votes] = nil
      item[:id] = r.at('a.pp-more-content-link')[:href][/ved=(\w+)/, 1] rescue nil
      # or possibly
      # item[:id] = r.at('a.pp-more-content-link')[:href][/ei=(\w+)/, 1]
      @job.save item
    end
  end
end

# this part helps me test it, it only gets run when we're testing.           
# we can comment it out once we're done testing

if __FILE__ == $0
  require 'pry'
  require_relative '../../scraper'          
 # job = Job.new('{"content_provider":"google", "module_type":"review", "url":"http://maps.google.de/maps/place?hl=de&ie=UTF-&cid=12995263981035548022&sa=X&oi=local_result&ct=placepage-link&resnum=1"}')
  
  Scraper.new(job).run
end

