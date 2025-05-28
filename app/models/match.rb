class Match < ApplicationRecord
  belongs_to :white_player, class_name: "Member"
  belongs_to :black_player, class_name: "Member"

  validates :white_player, presence: true
  validates :black_player, presence: true
  validates :result, presence: true, inclusion: { in: %w[white black draw], message: "%{value} is not a valid result" }

  validate :players_must_be_different

  private

  def players_must_be_different
    if white_player_id == black_player_id
      errors.add(:black_player, "must be different from white player")
    end
  end
end
