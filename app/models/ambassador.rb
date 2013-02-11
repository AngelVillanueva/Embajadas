# == Schema Information
#
# Table name: ambassadors
#
#  id                     :integer          not null, primary key
#  name                   :string(255)
#  embassy_id             :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  tracking_id            :string(255)
#

class Ambassador < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable, 
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :embassy_ids, :email, :password, :password_confirmation, :remember_me
  has_and_belongs_to_many :embassies
  has_many :points, dependent: :destroy
  has_many :missions, through: :points
  has_many :assignments, dependent: :destroy
  has_many :badges, dependent: :destroy
  has_many :rewards, through: :badges

  before_validation :assign_random_tracking_id

  # email and password presence are mandatory via devise
  validates :name, :tracking_id, presence: true
  validates :tracking_id, uniqueness: true

  ## FACEBOOK METHODS ##
  # helper method for quick Facebook Graph API access through Koala gem
  def facebook
    @facebook ||= Koala::Facebook::API.new(oauth_token)
    # error recovery (block-ish so can be shared across the rest of the Facebook methods)
    block_given? ? yield(@facebook) : @facebook
  rescue Koala::Facebook::APIError => e
    if Rails.env.production?
      logger.info e.to_s
      nil
    else
      raise e.to_yaml
    end
  end

  def friends_count
    # example of block-ish Facebook method [ex: current_ambassador.friends_count]
    facebook { |fb| fb.get_connection("me", "friends").size }
  end
  def fb_slogan_count(slogan)
    query = "select message from status where uid=me() and strpos(message, '#{slogan}')>=0"
    facebook { |fb| fb.fql_query(query).size }
  end
  ## end of FACEBOOK METHODS
  
  # if the Ambassador is created via OmniAuth the password field is not needed
  def password_required?
    super && provider.blank?
  end
  protected
  # assign a random tracking_id on Ambassador creation to avoid using the Ambassador id externally
  def assign_random_tracking_id
    if tracking_id.nil?
      self.tracking_id = get_unique_tracking_id
    end
  end
  def get_unique_tracking_id
    tracking_id = SecureRandom.hex 5
    matches = Ambassador.where(tracking_id: tracking_id)
    if matches.empty?
      tracking_id
    else
      get_unique_tracking_id
    end
  end
  # helper functions to complete the Ambassador creation via OmniAuth/Devise
  # create or update Ambassador info with the OmniAuth provider returned info
  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |ambassador|
      ambassador.provider = auth.provider
      ambassador.uid = auth.uid
      ambassador.name = auth.info.nickname
      ambassador.email = auth.info.email if auth.info.email
      ambassador.oauth_token = auth.credentials.token
      ambassador.oauth_expires_at = Time.at(auth.credentials.expires_at) if auth.credentials.expires_at
    end
  end
  # if there is an error saving the Ambassador via OmniAuth, the info is sent back to the create form to show the errors
  def self.new_with_session(params, session)
    if session["devise.ambassador_attributes"]
      new(session["devise.ambassador_attributes"], without_protection: true) do |ambassador|
        ambassador.attributes = params
        ambassador.valid?
      end
    else
      super
    end
  end
end
