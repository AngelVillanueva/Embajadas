# == Schema Information
#
# Table name: points
#
#  id            :integer          not null, primary key
#  mission_id    :integer
#  ambassador_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Point < ActiveRecord::Base
  belongs_to :ambassador
  belongs_to :mission
end
