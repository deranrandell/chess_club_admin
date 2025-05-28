require 'rails_helper'

RSpec.describe "Pages", type: :request do
  describe "GET /leaderboard" do
    it "returns http success" do
      get "/pages/leaderboard"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /members" do
    it "returns http success" do
      get "/pages/members"
      expect(response).to have_http_status(:success)
    end
  end

end
