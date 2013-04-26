class ContentProvider < ActiveRecord::Base
  has_many :ratings
  has_many :reviewers
  has_and_belongs_to_many :proxies

  def self.cp(contentprovider)
    where("name = ?", contentprovider).first
  end


end
