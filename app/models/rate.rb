class Rate < ActiveRecord::Base
  belongs_to :product
  belongs_to :user
  before_save :default_values
  attr_accessible :rate

def default_values
  self.rate ||=0
end
end
