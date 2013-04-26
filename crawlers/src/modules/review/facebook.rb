require 'chronic'

module Facebook

  def do_page page
    page.search('div.review').each do |div|
      item = {}
      # item[:reviewer_name] = 
      # item[:title] = 
      # item[:reviewer_image_url] = 
      # item[:date] =  
      # item[:rating] = 
      # item[:description] = 
      # item[:id] = 
      # item[:reviewer_url] = 
      # URI.join(@job.url, a[:href]).to_s
      @job.save item
    end
  end

  def scrape url
    page = get url
    company = {}

    doc = Nokogiri::HTML page.search('code.hidden_elem').map{|x| x.child.text}.join
    lines = doc.search('td[text()="Address"] + td li').map{|x| x.text}
    company[:street] = lines.shift
    if lines[0][/(.*), ([A-Z]{2}) (\d{5}.*)/]
      company[:postalcode] = $3
      company[:city] = $1
      company[:state] = $2
    end

    company[:name] = page.at('meta[property="og:title"]')[:content]
    # company[:street2] = 
    company[:phone1] = doc.at('td[text()="Phone"] + td').text
    # company[:phone2] = 
    company[:url] = page.at('meta[property="og:url"]')[:content]
    # company[:latitude] = 
    # company[:longitude] = 
    company[:category] = doc.at('span.fcg a:last').text
    company[:like_this] = doc.to_s[/(\d+) people like this/, 1]
    company[:have_been_here] = doc.to_s[/(\d+) people have been here/, 1]
    company[:talking_about_this] = doc.to_s[/(\d+) people are talking about this/, 1]

    @job.save_company company

    ### NO REVIEWS! ###

    # do_page page
=begin
    while next_link = page.at('h3 > a[text()$=">>"]')
      url = URI.join(@job.url, next_link[:href]).to_s
      page = get url
      do_page page
    end
=end
  end
end

if __FILE__ == $0
  require 'pry'
  require_relative '../../scraper'
  job = Job.new('{"content_provider":"facebook", "module_type":"review", "url":"http://www.facebook.com/pages/Pizzeria-Luigi/111740348861277"}')
  Scraper.new(job).run
end
