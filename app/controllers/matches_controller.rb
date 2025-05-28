class MatchesController < ApplicationController
  def new
    @match = Match.new
    @members = Member.order(:name)
  end

 def create
  @match = Match.new(match_params)

  if @match.save
    # Do some logic to update ranks
    redirect_to leaderboard_path, notice: "Match recorded and rankings updated."
  else
    @members = Member.order(:name)
    render :new, status: :unprocessable_entity
  end
 end


  private

  def match_params
    params.require(:match).permit(:white_player_id, :black_player_id, :result)
  end
end
