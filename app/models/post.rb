# == Schema Information
#
# Table name: posts
#
#  id            :integer          not null, primary key
#  provider      :string(255)
#  uid           :string(255)
#  message       :string(255)
#  created_time  :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  ambassador_id :integer
#

class Post < ActiveRecord::Base
  belongs_to :ambassador
end
