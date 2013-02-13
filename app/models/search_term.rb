# == Schema Information
#
# Table name: search_terms
#
#  id         :integer          not null, primary key
#  term       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  consul_id  :integer
#

class SearchTerm < ActiveRecord::Base
  attr_accessible :term
  belongs_to :consul
  has_many :slogans
  has_many :missions, through: :slogans

  validates :term, :consul_id, presence: true
end
