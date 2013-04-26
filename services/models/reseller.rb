class Reseller < ActiveRecord::Base
  belongs_to :reseller_category
  has_many :reseller_commissions
  has_and_belongs_to_many :accounts
  has_and_belongs_to_many :users
  
  def self.all_orgs(reseller_id)
    reseller = where("id =  ?", reseller_id).first
    acct = reseller.accounts
    acct.each do |a|
      begin
    @allorgs << a
  rescue
  end
  end
  end
  
 
  
end
