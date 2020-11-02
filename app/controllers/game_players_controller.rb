class GamePlayersController < ApplicationController
  before_action :set_game_player, only: [:show, :destroy]

  # GET /game_players
  # GET /game_players.json
  def index
    @game_players = GamePlayer.all
  end

  # GET /game_players/1
  # GET /game_players/1.json
  def show
  end

  # GET /game_players/new
  def new
    @game_player = GamePlayer.new
  end

  # POST /game_players
  # POST /game_players.json
  def create
    game = Game.find_by(pin: game_player_params[:pin], is_complete: false)
    
    unless game
      redirect_to(new_game_player_path, notice: "An active game with pin #{game_player_params[:pin]} was not found, please try again.") and return
    end

    @game_player = GamePlayer.new
    @game_player.user = current_user
    @game_player.game = game

    respond_to do |format|
      if @game_player.save
        format.html { redirect_to game_path(game), notice: 'Welcome to the Game!' }
        format.json { render :show, status: :created, location: @game_player }
      else
        format.html { render :new }
        format.json { render json: @game_player.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /game_players/1
  # DELETE /game_players/1.json
  def destroy
    @game_player.destroy
    respond_to do |format|
      format.html { redirect_to game_players_url, notice: 'Game player was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game_player
      @game_player = GamePlayer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def game_player_params
      params.require(:game_player).permit(:pin)
    end
end
