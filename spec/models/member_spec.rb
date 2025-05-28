require "rails_helper"

RSpec.describe Member, type: :model do
  describe "validations" do
    it "is valid with valid attributes" do
      member = Member.new(name: "Alice", email: "alice@example.com", birthday: "1990-01-01")
      expect(member).to be_valid
    end

    it "is invalid without a name" do
      member = Member.new(email: "no_name@example.com", birthday: "1990-01-01")
      expect(member).not_to be_valid
    end

    it "is invalid without an email" do
      member = Member.new(name: "No Email", birthday: "1990-01-01")
      expect(member).not_to be_valid
    end

    it "does not allow duplicate emails" do
      Member.create!(name: "User1", email: "duplicate@example.com", birthday: "1990-01-01")
      member = Member.new(name: "User2", email: "duplicate@example.com", birthday: "1991-01-01")
      expect(member).not_to be_valid
    end

    it "assigns games_played = 0 by default" do
      member = Member.create!(name: "Gamer", email: "gamer@example.com", birthday: "1992-01-01")
      expect(member.games_played).to eq(0)
    end

    it "assigns a unique rank in increasing order" do
      m1 = Member.create!(name: "Rank1", email: "r1@example.com", birthday: "1990-01-01")
      m2 = Member.create!(name: "Rank2", email: "r2@example.com", birthday: "1991-01-01")
      expect(m2.rank).to eq(m1.rank + 1)
    end

    it "ensures rank uniqueness" do
      m1 = Member.create!(name: "Original", email: "original@example.com", birthday: "1990-01-01")
      m2 = Member.new(name: "Manual", email: "manual@example.com", birthday: "1990-01-01", rank: m1.rank)
      expect(m2).not_to be_valid
    end
  end
end
