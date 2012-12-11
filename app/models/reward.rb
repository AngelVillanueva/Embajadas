# == Schema Information
#
# Table name: rewards
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  mission_id    :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  target_points :integer
#

class Reward < ActiveRecord::Base
  attr_accessible :name, :target_points, :mission_id
  belongs_to :mission
  has_many :badges, dependent: :destroy
  has_many :ambassadors, through: :badges
end
