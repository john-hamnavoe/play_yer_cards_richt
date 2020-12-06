class GamesController < ApplicationController
  include CableReady::Broadcaster

  before_action :authenticate_user!
  before_action :set_game, only: [:show, :edit, :update, :destroy]

  # GET /games
  # GET /games.json
  def index
    @games = Game.all
  end

  # GET /games/1
  # GET /games/1.json
  def show
  end

  # GET /games/new
  def new
    @game = Game.new
  end

  # GET /games/1/edit
  def edit
  end

  # POST /games
  # POST /games.json
  def create
    @game = Game.new(game_params)
    @game.user_id = current_user.id

    respond_to do |format|
      if @game.save
        format.html { redirect_to episodes_created_episode_path(@game.id), notice: 'Game was successfully created.' }
        format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /games/1
  # PATCH/PUT /games/1.json
  def update
    respond_to do |format|
      if @game.update(game_params)
        format.html { redirect_to @game, notice: 'Game was successfully updated.' }
        format.json { render :show, status: :ok, location: @game }
      else
        format.html { render :edit }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game.destroy
    respond_to do |format|
      format.html { redirect_to games_url, notice: 'Game was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def players
    @game = Game.eager_load(game_players: :user).find_by(id: params[:id])
    render partial: 'games/players', locals: { game: @game }
  end

  def players_answered
    @game = Game.find_by(id: params[:id])
    @game_player_answers = GamePlayerQuestionAnswer.eager_load(game_player: :user).where(game_question_id:  @game.current_game_question_id).order(:updated_at)
    render partial: 'games/players_answered', locals: { game_player_answers: @game_player_answers }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.eager_load(game_players: :user).find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def game_params
      params.require(:game).permit(:name, :user_id, :is_complete, :pin)
    end
end
