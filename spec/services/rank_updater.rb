require 'rails_helper'

RSpec.describe RankUpdater do
  let!(:member1) { Member.create!(name: "Player 1", email: "p1@example.com", rank: 1, games_played: 0) }
  let!(:member2) { Member.create!(name: "Player 2", email: "p2@example.com", rank: 2, games_played: 0) }
  let!(:member3) { Member.create!(name: "Player 3", email: "p3@example.com", rank: 3, games_played: 0) }

  describe "#call" do
    context "when result is a draw and rank gap > 1" do
      it "moves lower ranked player up by 1" do
        match = Match.create!(white_player: member3, black_player: member1, result: "draw")

        RankUpdater.new(match).call

        expect(member1.reload.rank).to eq(1)
        expect(member3.reload.rank).to eq(2)
      end
    end

    context "when white wins and winner.rank > loser.rank" do
      it "updates ranks accordingly" do
        match = Match.create!(white_player: member2, black_player: member3, result: "white")

        RankUpdater.new(match).call

        expect(member2.reload.rank).to be < member3.reload.rank
      end
    end

    context "when black wins and winner.rank > loser.rank" do
      it "updates ranks accordingly" do
        match = Match.create!(white_player: member3, black_player: member2, result: "black")

        RankUpdater.new(match).call

        expect(member2.reload.rank).to be < member3.reload.rank
      end
    end

    context "when winner.rank < loser.rank (winner already higher)" do
      it "does not change ranks" do
        match = Match.create!(white_player: member1, black_player: member3, result: "white")

        expect {
          RankUpdater.new(match).call
        }.not_to change { [ member1.reload.rank, member3.reload.rank ] }
      end
    end

    it "increments games played for both players" do
      match = Match.create!(white_player: member1, black_player: member2, result: "white")
      RankUpdater.new(match).call
      expect(member1.reload.games_played).to eq(1)
      expect(member2.reload.games_played).to eq(1)
    end
  end
end
