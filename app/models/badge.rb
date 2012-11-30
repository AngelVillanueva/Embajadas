# == Schema Information
#
# Table name: badges
#
#  id            :integer          not null, primary key
#  ambassador_id :integer
#  reward_id     :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Badge < ActiveRecord::Base
  belongs_to :ambassador
  belongs_to :reward
end
