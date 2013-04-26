class Category < ActiveRecord::Base
  has_many :organizations
end
