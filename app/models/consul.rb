# == Schema Information
#
# Table name: consuls
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
#  minister               :boolean          default(FALSE)
#

class Consul < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :embassy_id, :email, :password, :password_confirmation, :remember_me
  belongs_to :embassy
  has_many :search_terms

  # email and password fields mandatories via devise
  validates :name, :embassy_id, presence: true
end
