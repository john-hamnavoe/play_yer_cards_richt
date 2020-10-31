class GameQuestionsController < ApplicationController
  before_action :set_game_question, only: [:show, :edit, :update, :destroy]

  # GET /game_questions
  # GET /game_questions.json
  def index
    @game_questions = GameQuestion.all
  end

  # GET /game_questions/1
  # GET /game_questions/1.json
  def show
  end

  # GET /game_questions/new
  def new
    @game_question = GameQuestion.new
  end

  # GET /game_questions/1/edit
  def edit
  end

  # POST /game_questions
  # POST /game_questions.json
  def create
    @game_question = GameQuestion.new(game_question_params)

    respond_to do |format|
      if @game_question.save
        format.html { redirect_to @game_question, notice: 'Game question was successfully created.' }
        format.json { render :show, status: :created, location: @game_question }
      else
        format.html { render :new }
        format.json { render json: @game_question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /game_questions/1
  # PATCH/PUT /game_questions/1.json
  def update
    respond_to do |format|
      if @game_question.update(game_question_params)
        format.html { redirect_to @game_question, notice: 'Game question was successfully updated.' }
        format.json { render :show, status: :ok, location: @game_question }
      else
        format.html { render :edit }
        format.json { render json: @game_question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /game_questions/1
  # DELETE /game_questions/1.json
  def destroy
    @game_question.destroy
    respond_to do |format|
      format.html { redirect_to game_questions_url, notice: 'Game question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game_question
      @game_question = GameQuestion.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def game_question_params
      params.require(:game_question).permit(:game_id, :question_id, :current_card, :card_deck)
    end
end
