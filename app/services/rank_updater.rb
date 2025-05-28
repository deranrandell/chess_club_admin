class RankUpdater
  def initialize(match)
    @match = match
    @white = match.white_player
    @black = match.black_player
  end

  def call
    ActiveRecord::Base.transaction do
      increment_games_played
      update_ranks
      normalize_ranks
    end
  end

  private

  def increment_games_played
    @white.increment!(:games_played)
    @black.increment!(:games_played)
  end

  def update_ranks
    case @match.result
    when "draw" then handle_draw
    when "white" then handle_win(@white, @black)
    when "black" then handle_win(@black, @white)
    end
  end

  def handle_draw
    higher, lower = [ @white, @black ].sort_by(&:rank)
    return unless (lower.rank - higher.rank) > 1

    shift_and_update(lower, lower.rank - 1)
  end

def handle_win(winner, loser)
  return if winner.rank < loser.rank

  old_loser_rank = loser.rank
  new_loser_rank = old_loser_rank + 1
  winner_target = old_loser_rank + ((winner.rank - old_loser_rank) / 2.0).floor

  shift_member_at_rank(new_loser_rank)
  loser.update!(rank: new_loser_rank)

  if (below = Member.find_by(rank: new_loser_rank + 1))
    below.update!(rank: old_loser_rank)
  end

  shift_and_update(winner, winner_target)
end


  def shift_and_update(member, new_rank)
    temp_rank = Member.maximum(:rank).to_i + 10
    member.update!(rank: temp_rank)

    shift_member_at_rank(new_rank)
    member.update!(rank: new_rank)
  end

  def shift_member_at_rank(rank)
    member = Member.find_by(rank: rank)
    return unless member

    shift_member_at_rank(rank + 1)
    member.update!(rank: rank + 1)
  end

  def normalize_ranks
    Member.order(:rank).each.with_index(1) do |m, i|
      m.update!(rank: i)
    end
  end
end
