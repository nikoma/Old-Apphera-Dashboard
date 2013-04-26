module Qype
  def scrape url
    page = get(url).parser
    company = {}
    page.css('div.address span').remove rescue nil
    company['name'] = page.at('h1.fn').text.strip || "" rescue nil
    company['url'] = page.at('dd.place-box_info__contact p a').remove.text rescue nil
    company['phone'] = page.at('dd.place-box_info__contact').text.strip rescue nil
    company['street'], company['zip'], company['city'] = $1, $2, $3 if page.at('//dt[.="Adresse:"]/following-sibling::dd/p').text.strip[/(.*), (\d{5}) (.*)/] rescue nil
    company['category'] = /[^-]+$/i.match(page.title).to_s.strip
    company['latitude'] = page.at('//*/meta[starts-with(@property, \'og:latitude\')]')['content']
    company['longitude'] = page.at('//*/meta[starts-with(@property, \'og:longitude\')]')['content']
    @job.save_company company

    page.search('div.place-review').each do |div|
      pp "trying to get reviews"
      item = {}
      begin
        item[:id] = div.at("div.js-offensive-content")['data-url'][/\d+/]
        item[:description] = div.search('.place-review_text').text.strip

        raise 'no date' unless div.at('div.place-review_content__rating__info').text =~ /(\d+) (\S+) (\d{4})/
        item[:date] = Date.new $3.to_i, month($2), $1.to_i

        item[:rating] = div.search('.rating').text
        item[:reviewer_name] = div.at('a[@data-user-link]').text
        item[:reviewer_url] = div.at('a[@data-user-link]')['data-user-link']
        item[:reviewer_image_url] = div.at('img.user')[:src]
        pp item
        @job.save item
      rescue Exception => e
        binding.pry
      end
    end
  end
end

# this part helps me test it, it only gets run when we're testing.
# we can comment it out once we're done testing

if __FILE__ == $0
  require 'pry'
  require_relative '../../scraper'
  job = Job.new('{"content_provider":"qype", "module_type":"review", "url":"http://www.qype.com/place/13-Schluessel-Reese-GmbH-Hamburg"}')
  Scraper.new(job).run
end

