require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  let(:league) { League.create(sport: "Soccer") }
  let(:team) { Team.create(name: "TeamErica", league_id: 4) }
  let(:game) {  Game.create(address: "123 tree ln", time: Time.now, date: Date.new, home_score: 2, away_score: 4) }
  # # let(:team_game) { TeamGame.create(home_id: 3, away_id: 4, game_id: game.id) }
  # let(:home_team) { Team.find(game.team_games[0].home_id)}
  # let(:away_team) { Team.find(game.team_games[0].away_id) }

  describe "GET #show" do
    it "responds with a status code of 200" do
      get :show, params: {league_id: league.to_param, id: game.to_param}
      expect(response).to render_template('show')
    end
  end

  # describe "GET #new" do
  #   it "assigns a new game to @game" do
  #     get :new
  #     expect(assigns(:game)).to be_a_new Game
  #   end
  # end

  # describe "POST #create" do
  #   it "creates a new game in the database" do
  #     post :create, { game:}
  #     expect(response).to have_http_status(:success)
  #   end
  # end

end
