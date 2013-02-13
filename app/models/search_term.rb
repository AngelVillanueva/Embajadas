class SearchTerm < ActiveRecord::Base
  attr_accessible :term
  belongs_to :consul
  has_many :slogans
  has_many :missions, through: :slogans

  validates :term, :consul_id, presence: true
end