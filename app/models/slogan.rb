# == Schema Information
#
# Table name: slogans
#
#  id             :integer          not null, primary key
#  mission_id     :integer
#  search_term_id :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Slogan < ActiveRecord::Base
  belongs_to :mission
  belongs_to :search_term

  validates :mission, :search_term, presence: true
end
