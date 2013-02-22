# == Schema Information
#
# Table name: posts
#
#  id           :integer          not null, primary key
#  provider     :string(255)
#  uid          :string(255)
#  message      :string(255)
#  created_time :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Post < ActiveRecord::Base
end
