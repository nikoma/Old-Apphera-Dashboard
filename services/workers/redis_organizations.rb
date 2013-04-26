#!ruby19
# encoding: utf-8
require 'rubygems'
require 'bunny'
require_relative '../provider'
require 'degermatize'
require_relative 'settings'
require "redis"

redis = Redis.new
Organization.where("id > 0").find_each do |org|

redis.set(org.yahooslug, org.to_hash)
p org.id
end
