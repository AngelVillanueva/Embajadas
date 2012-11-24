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

  validates :name, uniqueness: true
end
