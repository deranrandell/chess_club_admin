class PagesController < ApplicationController
  def leaderboard
    @members = Member.order(:rank)
  end

  def members
    @members = Member.order(:rank)
  end
end
