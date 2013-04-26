class Contact < ActiveRecord::Base
  attr_accessible :city, :comment, :country, :email, :name, :phone, :subject
  validates :email, :presence => true
  validates :comment, :presence => true

end
