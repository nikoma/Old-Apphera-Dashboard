module Tripadvisor

  def do_page page
    divs = page.search(".inlineReviewUpdate")
    return unless divs.length > 0

    ids = page.body.scan(/review_(\d+)/).flatten[1..-1].uniq rescue nil
    url = "http://www.tripadvisor.#{@tld}/ExpandedUserReviews-#{@id}?target=#{ids[0]}&context=1&reviews=#{ids.join(',')}&servlet=#{@servlet}&expand=1"
    expanded = @agent.get url

    divs.each_with_index do |div, i|
      item = {}
      item[:id] = div.to_s[/review_(\d+)/, 1]
      item[:rating] = div.at('img.sprite-ratings')[:alt][/\d/]
      item[:date] = Date.new($3.to_i, @months.index($2), $1.to_i) if div.at('.ratingDate').text =~ /(\d+)\. (\w+) (\d{4})/ rescue nil
      item[:reviewer_name] = div.at('div.username span').text  rescue nil
      item[:title] = div.at('div.quote a').text.chars.to_a[1..-2].join  rescue nil
      # the expanded result has full description and images
      exp_div = expanded.parser.css('a[@id]').find { |a| a[:id]== "r#{item[:id]}" }.parent.parent.parent rescue nil
      item[:description] = exp_div.at_xpath('.//div[@class="entry"]/p').text.strip rescue nil
      item[:reviewer_image_url] = exp_div.at('img.avatar')[:src] rescue nil
      item[:reviewer_url] = URI.join(page.uri.to_s, "/members/#{CGI::escape(item[:reviewer_name])}").to_s rescue nil# this isn't right
    #  binding.pry unless item[:reviewer_image_url]
      @job.save item
    end
  end

  def scrape url
    if url =~ /(\w+_Review)-(.*?)-Reviews/
      @servlet, @id = $1, $2
    else
      puts "invalid slug: #{url}"
    end
    @tld = url[/tripadvisor.(\w+)/, 1]

    # different cases for .com or .de
    @months = case @tld
      when 'com' then
        %w{foo January February March April May June July August September October November December}
      when 'de' then
        %w{foo Januar February March April Mai Juni Juli August September Oktober November Dezember}
    end

    page = get url
    company = {}
    company['name'] = page.at('//h1[@property="v:name"]').text.strip rescue nil
    company['street'] = page.at('//span[@property="v:street-address"]').text.strip rescue nil
    company['zip'] =  page.at('//span[@property="v:postal-code"]').text.strip rescue nil
    company['city'] =  page.at('//span[@property="v:locality"]').text.strip rescue nil
    # can't find url or phone
    # company['url'] =
    # company['phone'] =
    @job.save_company company

    do_page page

    @page_num = 0
    while page.at('span.ie_rgt')
      @page_num += 10
      page = get url.gsub(/Reviews-/, "Reviews-or#{@page_num}-")
      do_page page
    end
  end

  def valid? url
    valid = url =~ /(\w+_Review)-(.*?)-Reviews/
    !!valid
  end
end

#if __FILE__ == $0
#  require 'pry'
#  require_relative '../../scraper'
#  job = Job.new('{"content_provider":"tripadvisor", "module_type":"review", "url":"http://www.tripadvisor.de/Hotel_Review-g551703-d1946007-Reviews-Woolacombe_Sands_Holiday_Park-Woolacombe_Devon_England.html"}')
#  Scraper.new(job).run
#end
