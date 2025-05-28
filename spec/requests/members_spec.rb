require 'rails_helper'

RSpec.describe "Members", type: :request do
  describe "DELETE /members/:id" do
    let!(:member1) { Member.create!(name: "Alice", email: "alice@example.com", birthday: "1990-01-01", rank: 1, games_played: 10) }
    let!(:member2) { Member.create!(name: "Bob", email: "bob@example.com", birthday: "1991-02-02", rank: 2, games_played: 8) }
    let!(:member3) { Member.create!(name: "Carol", email: "carol@example.com", birthday: "1992-03-03", rank: 3, games_played: 5) }

    it "deletes the member and adjusts ranks of subsequent members" do
      expect {
        delete member_path(member2)
      }.to change(Member, :count).by(-1)

      expect(response).to redirect_to(members_path)
      follow_redirect!

      # Reload remaining members to get updated ranks
      member1.reload
      member3.reload

      expect(member1.rank).to eq(1)
      expect(member3.rank).to eq(2)
    end
  end
end
