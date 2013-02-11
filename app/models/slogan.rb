class Slogan < ActiveRecord::Base
  belongs_to :mission
  belongs_to :search_term

  validates :mission, :search_term, presence: true
end