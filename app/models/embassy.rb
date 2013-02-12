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
  has_and_belongs_to_many :ambassadors
  has_many :consuls
  has_many :slogans

  validates :name, presence: true
  validates :name, uniqueness: true

  def assigned_slogans
    Slogan.where(mission_id: mission_ids)
  end

  def available_search_terms
    assigned_slogan_ids = Slogan.where(mission_id: self.mission_ids).map(&:search_term_id)
    SearchTerm.where(id: assigned_slogans.map(&:search_term_id))
  end
end
