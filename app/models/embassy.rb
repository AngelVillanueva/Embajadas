# == Schema Information
#
# Table name: embassies
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Embassy < ActiveRecord::Base
  attr_accessible :name
  has_many :missions, dependent: :destroy
  has_many :ambassadors
  has_many :consuls

  validates :name, uniqueness: true
end
