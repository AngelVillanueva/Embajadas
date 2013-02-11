class SearchTerm < ActiveRecord::Base
  attr_accessible :term
  has_many :slogans
  has_many :missions, through: :slogans

  validates :term, presence: true
end