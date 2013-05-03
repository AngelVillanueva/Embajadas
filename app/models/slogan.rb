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
  attr_accessible :mission_id, :search_term_id
  belongs_to :mission
  belongs_to :search_term
  has_many :posts

  validates :mission_id, :search_term_id, presence: true
end
