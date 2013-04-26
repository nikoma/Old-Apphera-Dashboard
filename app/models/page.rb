class Page < ActiveRecord::Base
  attr_accessible :body, :name, :slug
  extend FriendlyId
  friendly_id :name, use: :slugged
end
