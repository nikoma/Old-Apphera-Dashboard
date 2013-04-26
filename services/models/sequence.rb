class Sequence < ActiveRecord::Base
  #has_paper_trail
  has_and_belongs_to_many :sequence_items
end
