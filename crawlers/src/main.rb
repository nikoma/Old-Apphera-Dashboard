require_relative './scraper'

@scraper = Scraper.new

loop do
  begin
    @scraper.set_job Job.new
    @scraper.run
  rescue #Job::EmptyQueue => e
   # puts 'The queue is empty.'

  end
  sleep 5
end