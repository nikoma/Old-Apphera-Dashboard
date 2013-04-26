require_relative 'apphera_api'
require 'json'
require 'pp'

class Job
  attr_accessor :url, :provider, :module_type, :org_id

  def initialize test_json = nil
    if test_json
      json = JSON.parse test_json
    else
      payload = Queue::CRAWLERS.pop[:payload]
      raise Queue::EmptyQueue if 'queue_empty' == payload.to_s
      json = JSON.parse(payload)
     # p json
    end
    @category_id = json["category_id"]
    @org_id = json["org_id"]
    @url = json["url"]
    @provider = json["content_provider"]
    @module_type = json["module_type"]
  end

  def save review
    queue = "pending_reviews"
    review.merge!({'content_provider' => @provider, 'review_url' => @url, 'org_id' => @org_id, 'category_id' => @category_id})
    if ENV['development']
      pp review
      puts queue
      #Queue::EXCHANGE.publish(review.to_json, key: queue)
    else
      pp review
      Queue::EXCHANGE.publish(review.to_json, key: queue)
    end
  end

  def save_company company
    company.merge!({'content_provider' => @provider, 'review_url' => @url, 'org_id' => @org_id}) #todo: use url to "re-match"
    if ENV['development']
      pp company
    else
      pp company
      Queue::EXCHANGE.publish(company.to_json, key: "company_listings")
    end
  end

end
