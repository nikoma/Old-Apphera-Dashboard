# TODO: god vs monit


God.watch do |w|
  w.name = "apphera-foursquare"
  w.start = "ruby /home/apphera/social-media-monitoring-open-source/apphera-services/services/workers/foursquare.rb"
  w.log = '/home/apphera/apphera-services/log/apphera.log'
  w.keepalive
  w.transition(:up, :start) do |on|
    on.condition(:process_exits) do |c|
      c.notify = 'nikolai'
    end
  end
end
God.watch do |w|
  w.name = "apphera-OBSERVER"
  w.start = "ruby /home/apphera/social-media-monitoring-open-source/apphera-services/services/workers/apphera_observer.rb"
  w.log = '/home/apphera/apphera-services/log/apphera.log'
  w.keepalive
  w.transition(:up, :start) do |on|
    on.condition(:process_exits) do |c|
      c.notify = 'nikolai'
    end
  end
end

God.watch do |w|
  w.name = "apphera-aggregate"
  w.start = "ruby /home/apphera/social-media-monitoring-open-source/apphera-services/services/workers/aggregate.rb"
  w.log = '/home/apphera/apphera-services/log/apphera.log'
  w.keepalive
  w.transition(:up, :start) do |on|
    on.condition(:process_exits) do |c|
      c.notify = 'nikolai'
    end
  end
end
God.watch do |w|
  w.name = "apphera-geo"
  w.start = "ruby /home/apphera/social-media-monitoring-open-source/apphera-services/services/workers/apphera_geo.rb"
  w.log = '/home/apphera/apphera-services/log/apphera.log'
  w.keepalive
  w.transition(:up, :start) do |on|
    on.condition(:process_exits) do |c|
      c.notify = 'nikolai'
    end
  end
end
a = 0
3.times do
  a += 1
  God.watch do |w|
    w.name = "apphera-google-slug-" + a.to_s
    w.start = "ruby /home/apphera/social-media-monitoring-open-source/services/workers/google_slug.rb"
    w.log = '/home/apphera/apphera-services/log/apphera.log'
    w.keepalive
    w.transition(:up, :start) do |on|
      on.condition(:process_exits) do |c|
        c.notify = 'nikolai'
      end
    end
  end
end
a = 0
1.times do
  a += 1
  God.watch do |w|
    w.name = "apphera-pending-listing" + a.to_s
    w.start = "ruby /home/apphera/social-media-monitoring-open-source/services/workers/pending_listing_writer.rb"
    w.log = '/home/apphera/apphera-services/log/apphera.log'
    w.keepalive
    w.transition(:up, :start) do |on|
      on.condition(:process_exits) do |c|
        c.notify = 'nikolai'
      end
    end
  end
end
God.watch do |w|
  w.name = "apphera-bing-links"
  w.start = "ruby /home/apphera/social-media-monitoring-open-source/services/workers/bing_api.rb"
  w.log = '/home/apphera/apphera-services/log/apphera.log'
  w.keepalive
  w.transition(:up, :start) do |on|
    on.condition(:process_exits) do |c|
      c.notify = 'nikolai'
    end
  end
end
a = 0
3.times do
  a += 1
  God.watch do |w|
    w.name = "apphera-ranks-" + a.to_s
    w.start = "ruby /home/apphera/social-media-monitoring-open-source/services/workers/ranks_elastic.rb"
    w.log = '/home/apphera/apphera-services/log/apphera.log'
    w.keepalive
    w.transition(:up, :start) do |on|
      on.condition(:process_exits) do |c|
        c.notify = 'nikolai'
      end
    end
  end
end
#a = 0
#5.times do
#  a += 1
God.watch do |w|
  w.name = "pending-competitors-writer" #+ a.to_s
  w.start = "ruby /home/apphera/social-media-monitoring-open-source/services/workers/pending_competitors_writer.rb"
  w.log = '/home/apphera/apphera-services/log/apphera.log'
  w.keepalive
  w.transition(:up, :start) do |on|
    on.condition(:process_exits) do |c|
      c.notify = 'nikolai'
    end
  end
end
#end
a = 0
1.times do
  a += 1
  God.watch do |w|
    w.name = "pending-review-writer-" + a.to_s
    w.start = "ruby /home/apphera/social-media-monitoring-open-source/services/workers/pending_review_writer.rb"
    w.log = '/home/apphera/apphera-services/log/apphera.log'
    w.keepalive
    w.transition(:up, :start) do |on|
      on.condition(:process_exits) do |c|
        c.notify = 'nikolai'
      end
    end
  end
end
a = 0
God.watch do |w|
  w.name = "apphera-master"
  w.start = "ruby /home/apphera/social-media-monitoring-open-source/services/workers/apphera_master_rabbit.rb"
  w.log = '/home/apphera/apphera-services/log/apphera.log'
  w.keepalive
  w.transition(:up, :start) do |on|
    on.condition(:process_exits) do |c|
      c.notify = 'nikolai'
    end
  end
end
God.watch do |w|
  w.name = "apphera-stats-mailer"
  w.start = "ruby /home/apphera/social-media-monitoring-open-source/services/workers/stats_mailer.rb"
  w.log = '/home/apphera/apphera-services/log/apphera.log'
  w.keepalive
  w.transition(:up, :start) do |on|
    on.condition(:process_exits) do |c|
      c.notify = 'nikolai'
    end
  end
end
#God.watch do |w|
#  w.name = "apphera-twitter"
#  w.start = "ruby /home/apphera/apphera-services/workers/twitter_elastic.rb"
#  w.log = '/home/apphera/apphera-services/log/apphera.log'
#  w.keepalive
#  w.transition(:up, :start) do |on|
#    on.condition(:process_exits) do |c|
#      c.notify = 'nikolai'
#    end
#  end
#end
#God.watch do |w|
#  w.name = "apphera-twitter-writer"
#  w.start = "ruby /home/apphera/apphera-services/workers/twitter_writer_mongo.rb"
#  w.log = '/home/apphera/apphera-services/log/apphera.log'
#  w.keepalive
#  w.transition(:up, :start) do |on|
#    on.condition(:process_exits) do |c|
#      c.notify = 'nikolai'
#    end
#  end
#end
5.times do
  a += 1
  God.watch do |w|
    w.name = "apphera-main-"+a.to_s
    w.start = "ruby /home/apphera/social-media-monitoring-open-source/crawlers/src/main.rb"
    w.log = '/home/apphera/apphera-services/log/apphera.log'
    w.keepalive
    w.transition(:up, :start) do |on|
      on.condition(:process_exits) do |c|
        c.notify = 'nikolai'
      end
    end
  end
end
#40.times do
#  a += 1
#  God.watch do |w|
#    w.name = "apphera-proxy-tester-"+a.to_s
#    w.start = "ruby /home/apphera/apphera-services/workers/proxy_tester.rb"
#    w.log = '/home/apphera/apphera-services/log/apphera.log'
#    w.keepalive
#    w.transition(:up, :start) do |on|
#      on.condition(:process_exits) do |c|
#        c.notify = 'nikolai'
#      end
#    end
#  end
#end

#1.times do
#  a += 1
#  God.watch do |w|
#    w.name = "apphera-proxy-list-"+a.to_s
#    w.start = "ruby /home/apphera/apphera-services/workers/proxy_list.rb"
#    w.log = '/home/apphera/apphera-services/log/apphera.log'
#    w.keepalive
#    w.transition(:up, :start) do |on|
#      on.condition(:process_exits) do |c|
#        c.notify = 'nikolai'
#      end
#    end
#  end
#end






