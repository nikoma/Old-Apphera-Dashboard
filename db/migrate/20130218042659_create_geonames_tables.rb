class CreateGeonamesTables < ActiveRecord::Migration
  def self.up
    # blah
    %w(countries cities).each { |t| drop_table t }

    # # create countries
    create_table :countries do |t|
      # [0] iso alpha2
      t.string :iso_code_two_letter, :null => false
      # [1] iso alpha3
      t.string :iso_code_three_letter, :null => false
      # [2] iso numeric
      t.integer :iso_number, :null => false
      # [3] fips code
      # [4] name
      t.string :name, :null => false
      # [5] capital
      t.string :capital
      # [6] areaInSqKm
      t.integer :area_in_square_km
      # [7] population
      t.integer :population
      # [8] continent
      t.string :continent
      # [9] top level domain
      # [10] Currency code
      t.string :currency_code
      # [11] Currency name
      t.string :currency_name
      # [12] Phone
      t.string :phone
      # [13] Postal Code Format
      # [14] Postal Code Regex
      # [15] Languages
      t.string :languages
      # [16] Geoname id
      t.integer :geonames_id #, :null => false
      # [17] Neighbours
      # [18] Equivalent Fips Code
    end

    add_index :countries, :iso_code_two_letter, :unique => true
    add_index :countries, :geonames_id, :null => false

    # create cities
    create_table :cities do |t|
      t.integer :country_id, :null => false
      t.integer :division_id
      # [0] geonameid : integer id of record in geonames database
      t.integer :geonames_id, :null => false
      # [1] name : name of geographical point (utf8) varchar(200)
      t.string :name, :null => false
      # [2] asciiname : name of geographical point in plain ascii characters, varchar(200)
      t.string :ascii_name
      # [3] alternatenames : alternatenames, comma separated varchar(4000)
      t.text :alternate_name
      # [4] latitude : latitude in decimal degrees (wgs84)
      t.decimal :latitude, :precision => 14, :scale => 8, :null => false
      # [5] longitude : longitude in decimal degrees (wgs84)
      t.decimal :longitude, :precision => 14, :scale => 8, :null => false
      # [6] feature class : see http://www.geonames.org/export/codes.html, char(1)
      # [7] feature code : see http://www.geonames.org/export/codes.html, varchar(10)
      # [8] country code : ISO-3166 2-letter country code, 2 characters
      t.string :country_iso_code_two_letters
      # [9] cc2 : alternate country codes, comma separated, ISO-3166 2-letter country code, 60 characters
      # [10] admin1 code : fipscode (subject to change to iso code), isocode for the us and ch, see file admin1Codes.txt for display names of this code; varchar(20)
      t.string :admin_1_code
      # [11] admin2 code : code for the second administrative division, a county in the US, see file admin2Codes.txt; varchar(80)
      t.string :admin_2_code
      # [12] admin3 code : code for third level administrative division, varchar(20)
      t.string :admin_3_code
      # [13] admin4 code : code for fourth level administrative division, varchar(20)
      t.string :admin_4_code
      # [14] population : integer
      t.integer :population
      # [15] elevation : in meters, integer
      t.integer :elevation
      # [16] gtopo30 : average elevation of 30'x30' (ca 900mx900m) area in meters, integer
      # [17] timezone : the timezone id (see file timeZone.txt)
      t.integer :geonames_timezone_id
      # [18] modification date : date of last modification in yyyy-MM-dd format
    end

    add_index :cities, :geonames_id, :unique => true

    create_table :divisions do |t|
      t.integer :country_id
      t.string :code
      t.string :full_code
      t.string :name
      t.string :ascii_name
      t.integer :geonames_id
    end

    add_index :divisions, :full_code, :unique => true
    add_index :divisions, :code
    add_index :divisions, :geonames_id, :unique => true
  end

  def self.down
    # drop all the tables
    %w(countries cities divisions).each { |t| drop_table t }
  end
end