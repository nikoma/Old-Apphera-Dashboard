module Pointoo
  def scrape url
    page = get(url).parser
    company = {}
    page.css('div.address span').remove
    company['name'] = page.at('h1.fn').text.strip rescue nil
    company['phone'] = page.at('div.address').text[/Telefon: (.*)/, 1] rescue nil
    company['url'] = page.at('div.address a')[:href] rescue nil
    company['street'], company['zip'], company['city'] = $1.strip, $2, $3 if page.at('div.address').text =~ /([^\n]+)\s*(\d{5}) ([^\n]*)/m
    @job.save_company company

    page.search('ul#text-ratings-list li').each do |li|
      item = {}
      item[:id] = li[:id][/\d+/]
      item[:title] = li.at('h4').text rescue nil
      item[:description] = li.at('span.description p').text rescue nil
      item[:rating] = li.at('span.rating span.value-title')[:title] rescue nil
      item[:votes] = li['data-votes'] rescue nil
      item[:date] = Date.new($3.to_i, $2.to_i, $1.to_i) if li.at('small').text =~ /(\d+)\.(\d+)\.(\d{4})/
      item[:reviewer_name] = li.at('img.profile-image')[:alt] rescue nil
      item[:reviewer_url] = URI.join(url, li.at('small a')[:href]).to_s rescue nil
      item[:reviewer_image_url] = URI.join(url, li.at('img.profile-image')[:src]).to_s rescue nil
      @job.save item
    end
  end
end

# this part helps me test it, it only gets run when we're testing.
# we can comment it out once we're done testing

if __FILE__ == $0
  require 'pry'
  require_relative '../../scraper'
  job = Job.new('{"content_provider":"pointoo", "module_type":"review", "url":"http://www.pointoo.de/poi/Hamburg/Restaurant-Da-Franco-145583.html"}')
  Scraper.new(job).run
end
