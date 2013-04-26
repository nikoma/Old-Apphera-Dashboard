# encoding: utf-8
require 'rubygems'
require "bundler/setup"

require 'active_record'
require 'active_model'
require 'active_record/associations'
require 'active_record/errors'
require 'activerecord-import'
require 'yaml'
require 'tire'
# require 'models/proxy'
# require 'models/organization'
# require 'models/content_provider'

Dir[File.dirname(__FILE__) + '/models/*.rb'].each do |file| 
  begin
  require file
rescue
end
end

module Database
    ActiveRecord::Base.establish_connection(YAML.load_file(File.dirname(__FILE__) + "/config/database.yml")) 
      
end
