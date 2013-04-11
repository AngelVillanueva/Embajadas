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
  has_many :mailing_codes

  after_create :assign_mailing_code

  validates :name, presence: true
  validates :name, uniqueness: true

  def assigned_slogans
    Slogan.where(mission_id: mission_ids)
  end

  def available_search_terms
    SearchTerm.where(consul_id: consul_ids)
  end

  protected
  def assign_mailing_code
    mc = MailingCode.new
    mc.embassy = self
    mc.expires_at = 2.week.from_now
    mc.save!
  end
end
