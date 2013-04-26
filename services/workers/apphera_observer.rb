#!ruby19
# encoding: utf-8

$LOAD_PATH.unshift File.dirname(__FILE__)
require_relative '../provider'
require_relative '../database'
#reqre 'json'
include Provider
require 'settings'
require_relative 'alert_sms'
#require 'bunny'

loop do
  observer = JobObserver.where("updated_at < ?", 5.minutes.ago)
  observer.each do |o|
    schedule = o.schedule
    @org = Organization.find(schedule.organization_id)

    success = false
    case schedule.sequence_id
      when 3 # daily crawl
        success = !@org.listings.empty?
      when 2
        success = !@org.organizations.reload.empty?
      when 6
        success = !org.provider_slugs.reload.empty?
        o.retry_count = 99
      else
        success = true
    end
    if success
      o.delete
      schedule.in_progress = false
      Schedule.create!(name: "aggregate", organization_id: @org.id, in_progress: false, sequence_id: 5, scheduled: DateTime.yesterday)

      if schedule.sequence_id == 2
        schedule.delete
        next
      end
      schedule.save
    elsif o.retry_count > 3
      FailedJob.create!(organization_id: @org.id, retry_count: o.retry_count, reason: "Too many retries", schedule_id: schedule.id)
      #AlertSms.new.send_message("The following job has failed: #{org.name}, at retry count: #{o.retry_count}")
      o.delete
    else
      o.retry_count += 1
      schedule.scheduled = DateTime.now - 5.minutes
      schedule.in_progress = false
      o.save
      schedule.save
    end
  end
  sleep 1
end