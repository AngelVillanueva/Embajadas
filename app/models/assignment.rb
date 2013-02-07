# == Schema Information
#
# Table name: assignments
#
#  id            :integer          not null, primary key
#  code          :string(255)
#  tracking_url  :text
#  short_url     :string(255)
#  mission_id    :integer
#  ambassador_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Assignment < ActiveRecord::Base
  belongs_to :ambassador
  belongs_to :mission

  before_validation :assign_code, :assign_tracking_url, :assign_short_url

  validates :ambassador_id, :mission_id, :code, :tracking_url, :short_url, presence: true
  validate :same_scope?

  protected
  # ambassador and mission belongs to the same embassy?
  def same_scope?
    if ambassador && mission
      errors.add(:base, "Ambassador and Mission do not belong to the same Embassy") unless ambassador.embassies.include? mission.embassy
    end
  end
  # automatically assigns a tracking_code for any new assignment (example: offline tracking?)
  def assign_code
    if code.nil?
      self.code = get_unique_tracking_code
    end
  end
  def get_unique_tracking_code
    code = SecureRandom.hex 4
    if Assignment.where(code: code).empty?
      code
    else
      get_unique_tracking_code
    end
  end
  # automatically builds the tracking url, containing both the ambassador tracking_id and the destination url (entered by the Consul for the Mission)
  def assign_tracking_url
    if tracking_url.nil?
      self.tracking_url = build_tracking_url(mission_id, ambassador_id)
    end
  end
  def build_tracking_url(mission_id, ambassador_id)
    mt = Mission.find(mission_id).tracking_url
    at = Ambassador.find(ambassador_id).tracking_id
    #own = 'http://127.0.0.1:3000/cooker/?tamb=' << at << '&emb_url='
    own = "#{Rails.configuration.custom_config_cookie_host}/cooker/?tamb=" << at << '&emb_url='
    protocol = ''
    protocol = 'http://' unless mt.match /^http:\/\//
    tracking_url = own << protocol << mt
  end
  # automatically shortens the tracking url through bitly api
  def assign_short_url
    require 'bitly'
    Bitly.use_api_version_3
    bitly = Bitly.new('embassyland', 'R_4a3b8272b7634f605382c8e02e809378')
    if short_url.nil?
      tu = build_tracking_url(mission_id, ambassador_id)
      su = bitly.shorten(tu)
      self.short_url = su.short_url
    end
  end
end
