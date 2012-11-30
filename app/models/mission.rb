# == Schema Information
#
# Table name: missions
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  embassy_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Mission < ActiveRecord::Base
  attr_accessible :name, :embassy_id
  belongs_to :embassy
  has_many :points
  has_many :ambassadors, through: :points
  has_many :rewards
end
