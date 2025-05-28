class PagesController < ApplicationController
  def leaderboard
  end

  def members
    @members = Member.order(:rank)
  end
end
