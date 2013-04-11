# == Schema Information
#
# Table name: mailing_codes
#
#  id            :integer          not null, primary key
#  tracking_code :string(255)
#  embassy_id    :integer
#  expires_at    :datetime
#  landing_url   :text
#  short_url     :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class MailingCode < ActiveRecord::Base
  belongs_to :embassy
  attr_accessible :embassy_id, :expires_at

  before_validation :assign_random_tracking_code, :build_landing_url

  validates :tracking_code, :embassy_id, :expires_at, :landing_url, presence: true
  validates :tracking_code, uniqueness: true

  protected
  # assign a random tracking_code on MailingCode creation to avoid using externally app ids
  def assign_random_tracking_code
    if tracking_code.nil?
      self.tracking_code = get_unique_tracking_code
    end
  end
  # assign unique code
  def get_unique_tracking_code
    tracking_code = SecureRandom.hex 5
    matches = MailingCode.where(tracking_code: tracking_code)
    if matches.empty?
      tracking_code
    else
      get_unique_tracking_code
    end
  end
  # builds the landing url for mailings to customers (long version)
  def build_landing_url(locale = I18n.locale)
    if self.landing_url.nil?
      project_host = "#{PROJECT_CONFIG['host']}"
      sign_in_route = Rails.application.routes.url_helpers.new_ambassador_session_path(locale: locale, etr: self.tracking_code)
      self.landing_url = project_host + sign_in_route
    end
  end
end
