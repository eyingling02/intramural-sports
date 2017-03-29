require 'rails_helper'

RSpec.describe GamesController, type: :controller do

  describe "GET #players" do
    it "returns http success" do
      get :players
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #teams" do
    it "returns http success" do
      get :teams
      expect(response).to have_http_status(:success)
    end
  end

end
