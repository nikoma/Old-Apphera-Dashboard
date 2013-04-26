class User < ActiveRecord::Base
  has_paper_trail
  belongs_to :account
  has_many :history_items
  has_and_belongs_to_many :resellers
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me

  validates :name, :presence => true

  def reseller?
      !self.resellers.empty?
    end

end
