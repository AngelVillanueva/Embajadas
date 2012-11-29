class Badge < ActiveRecord::Base
  belongs_to :ambassador
  belongs_to :reward
end