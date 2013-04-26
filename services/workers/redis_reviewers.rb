#!ruby19
# encoding: utf-8
require 'rubygems'
require 'bunny'
require_relative '../provider'
require 'degermatize'
require_relative 'settings'
require "redis"

redis = Redis.new
Reviewer.where("id > 0").find_each do |reviewer|
redis.set(reviewer.slug, reviewer.id)
p reviewer.id
end
