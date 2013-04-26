class ContentProvider < ActiveRecord::Base
  has_many :ratings
  has_many :reviewers
  has_and_belongs_to_many :proxies
attr_accessible :id, :name, :description, :url 
  def self.cp(contentprovider)
    where("name = ?", contentprovider).first
  end


end
