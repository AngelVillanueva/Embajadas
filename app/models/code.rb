class Code < ActiveRecord::Base
  belongs_to :ambassador
  belongs_to :mission
end