# == Schema Information
#
# Table name: missions
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  embassy_id        :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  short_description :text
#  tracking_id       :string(255)
#  tracking_url      :text
#

class Mission < ActiveRecord::Base
  attr_accessible :name, :short_description, :embassy_id, :tracking_url
  belongs_to :embassy
  has_many :points, dependent: :destroy
  has_many :ambassadors, through: :points
  has_many :assignments, dependent: :destroy
  has_many :rewards, dependent: :destroy
  has_many :slogans
  has_many :search_terms, through: :slogans

  before_validation :assign_tracking_id

  validates :name, :short_description, :embassy_id, :tracking_url, :tracking_id, presence: true
  validates :tracking_id, uniqueness: true

  protected
  def assign_tracking_id
    if tracking_id.nil?
      self.tracking_id = get_unique_tracking_id
    end
  end
  def get_unique_tracking_id
    tracking_id = SecureRandom.hex 5
    checked = Mission.where(tracking_id: tracking_id)
    if checked.empty?
      tracking_id
    else
      get_unique_tracking_id
    end
  end
end
