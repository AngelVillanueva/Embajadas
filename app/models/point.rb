# == Schema Information
#
# Table name: points
#
#  id            :integer          not null, primary key
#  mission_id    :integer
#  ambassador_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Point < ActiveRecord::Base
  belongs_to :ambassador
  belongs_to :mission

  after_save :assign_badges

  validates :ambassador_id, :mission_id, presence: true

  private
  def assign_badges
    ambassador_points = ambassador.points.where(mission_id: mission.id).count
    reward = Reward.where(mission_id: mission.id)
    reward.each do |r|
      target_points = r.target_points
      if ambassador_points >= target_points && ambassador.badges.where(reward_id: r.id).empty?
        badge = Badge.new
        badge.ambassador = ambassador
        badge.reward = r
        badge.save
      end
    end
  end
end
