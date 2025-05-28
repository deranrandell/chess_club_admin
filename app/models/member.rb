class Member < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :rank, uniqueness: true
  before_validation :assign_rank, on: :create
  after_initialize :set_defaults, if: :new_record?

  private

  def set_defaults
    self.games_played ||= 0
  end

  def assign_rank
    self.rank ||= (Member.maximum(:rank) || 0) + 1
  end
end
