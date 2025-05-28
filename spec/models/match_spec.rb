require 'rails_helper'

RSpec.describe Match, type: :model do
  let!(:white_player) { Member.create!(name: "White Player", email: "white@example.com", rank: 1) }
  let!(:black_player) { Member.create!(name: "Black Player", email: "black@example.com", rank: 2) }

  subject {
    described_class.new(
      white_player: white_player,
      black_player: black_player,
      result: "white"
    )
  }

  describe "validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without white_player" do
      subject.white_player = nil
      expect(subject).not_to be_valid
      expect(subject.errors[:white_player]).to include("must exist")
    end

    it "is not valid without black_player" do
      subject.black_player = nil
      expect(subject).not_to be_valid
      expect(subject.errors[:black_player]).to include("must exist")
    end

    it "is not valid if white_player and black_player are the same" do
      subject.black_player = white_player
      expect(subject).not_to be_valid
      expect(subject.errors[:black_player]).to include("must be different from white player")
    end
  end
end
