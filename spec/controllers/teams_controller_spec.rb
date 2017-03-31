require 'rails_helper'

RSpec.describe TeamsController, type: :controller do
  let!(:league) { League.create!(sport: "Soccer") }
  let!(:team) { Team.create!(name: "TeamErica", league_id: 4) }
  let!(:game) {  Game.create(address: "123 tree ln", time: Time.now, date: Date.new, home_score: 2, away_score: 4)
}
end
