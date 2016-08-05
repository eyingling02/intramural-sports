class GamesController < ApplicationController
  def index
    @games = Game.all
  end

  def show
    @game = Game.find(params[:id])
    @home_team = Team.find(TeamGame.find(@game.id).home_id)
    @away_team = Team.find(TeamGame.find(@game.id).away_id)
    @league = League.find(@home_team.league_id)
  end

  def edit
  end

  def new
  end

  def create
    home_team = Team.find_by(name: params[:game][:home_team])
    away_team = Team.find_by(name: params[:game][:away_team])
    @game = Game.create(location: params[:game][:address], date: params[:game][:date], home_score: 0, away_score: 0)
    @team_game = TeamGame.create(away_id: away_team.id, home_id: home_team.id, game_id: @game.id)
    @league = League.find(home_team.league_id)
    if @game.valid?
      send_text_message(home_team, away_team, @game.location, @game.date)
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

  def send_text_message(home_team, away_team, location, date)
    numbers_to_send_to = ["+14156761348", "+19163979287", "+16109384104", "+12405430299", "+16109384104"]
    twilio_body = "New Game has been created! #{home_team.name} VS #{away_team.name} located at: #{location} Game starts at: #{date}. Be there or B^2!"

    twilio_sid = ENV['TWILIO_ACCOUNT_SID']
    twilio_token = ENV['TWILIO_AUTH_TOKEN']
    twilio_phone_number = ENV['TWILIO_NUMBER']

    @twilio_client = Twilio::REST::Client.new(twilio_sid, twilio_token)
    numbers_to_send_to.each do |number|
      @twilio_client.account.sms.messages.create(
        :from => twilio_phone_number,
        :to => number,
        :body => twilio_body
        )
    end
  end
end
