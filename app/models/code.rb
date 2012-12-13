# == Schema Information
#
# Table name: codes
#
#  id            :integer          not null, primary key
#  code          :string(255)
#  ambassador_id :integer
#  mission_id    :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Code < ActiveRecord::Base
  belongs_to :ambassador
  belongs_to :mission

  before_validation :assign_code

  validates :code, presence: true

  protected
  def assign_code
    if code.nil?
      self.code = get_unique_tracking_code
    end
  end
  def get_unique_tracking_code
    code = SecureRandom.hex 4
    if Code.where(code: code).empty?
      code
    else
      get_unique_tracking_code
    end
  end
end
