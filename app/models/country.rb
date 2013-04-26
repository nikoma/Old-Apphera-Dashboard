class Country < ActiveRecord::Base
  attr_accessible :iso_code_two_letter, :iso_code_three_letter, :iso_number, :name, :capital, :population, :continent, :currency_name, :currency_code, :geonames_id, :phone, :languages, :area_in_square_km
  has_many :cities
  has_many :categories
  def self.select_countries
    self.all.map { |item| [item.name,item.id]}
  end
end