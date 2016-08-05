class GamesController < ApplicationController

	def index

		@games = Game.all

	end


	def show
		@game = Game.find(params[:id])
		p @game.teams
		@home_team = Team.find(TeamGame.find(@game.id).home_id)
		@away_team = Team.find(TeamGame.find(@game.id).away_id)
		@league = League.find(@home_team.league_id)
	end


	def edit


	end


	def new

	end

	def create
		p home_team = Team.find_by(name: params[:game][:home_team])
		p away_team = Team.find_by(name: params[:game][:away_team])
		@game = Game.create(location: params[:game][:address], date: params[:game][:date], home_score: 0, away_score: 0)
		@team_game = TeamGame.create(away_id: away_team.id, home_id: home_team.id, game_id: @game.id)
		p @game.valid?
		p "*" *100
		p @game
		@league = League.find(home_team.league_id)
		if @game.valid?
			redirect_to "/leagues/#{@league.id}/games/#{@game.id}"
		else
			redirect_to "/leagues/#{@league.id}/teams/#{home_team.id}"
		end
	end

def update
	@game = Game.find(params[:id])
	@league = League.find(Team.find(Game.find(params[:id]).away_id).league_id)
	if @game.update_attributes(home_score: params[:home_score].to_i, away_score: params[:away_score].to_i)
		redirect_to "/leagues/#{@league.id}/games/#{@game.id}"
	end
end



end
