class CountryCodes < ActiveRecord::Base
  attr_accessible :code, :name
  has_many :organizations, :foreign_key => "country_code_id"
end
