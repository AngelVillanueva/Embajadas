class Ambassador < ActiveRecord::Base
  attr_accessible :name
  belongs_to :embassy
end