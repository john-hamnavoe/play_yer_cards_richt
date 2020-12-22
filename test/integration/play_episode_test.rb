require 'test_helper'

class PlayEpisodeTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    @game = games(:one)
    @four = users(:four)
    @five = users(:five)
    @six = users(:six)

    @game_player_four = game_players(:four)
    @game_player_five = game_players(:five)
    @game_player_six = game_players(:six)
  end

  test "all answer correctly" do
    sign_in @user
    assert_equal @game.game_state, GameState::CREATED
    get game_url(@game)
    assert_redirected_to episodes_created_episode_url(@game)

    get episodes_host_question_episode_url(@game)
    player_five_answer(1974)
    player_six_answer(1974)
    player_four_answer(1974)
    @game.reload
    assert_equal @game.game_state, GameState::QUESTION_PLAY

    get episodes_host_answer_episode_url(@game)
    @game.reload
    assert_equal @game.game_state, GameState::QUESTION_ANSWER
    game_player_question_answers = assigns(:game_player_question_answers)
    assert_equal @game_player_five.id, game_player_question_answers[0].game_player_id
    assert_equal @game_player_six.id, game_player_question_answers[1].game_player_id
    assert_equal @game_player_four.id, game_player_question_answers[2].game_player_id
  end

  test "all answer differently" do
    sign_in @user
    assert_equal @game.game_state, GameState::CREATED
    get game_url(@game)
    assert_redirected_to episodes_created_episode_url(@game)

    get episodes_host_question_episode_url(@game)
    player_five_answer(1976)
    player_six_answer(1974)
    player_four_answer(1973)
    @game.reload
    assert_equal @game.game_state, GameState::QUESTION_PLAY

    get episodes_host_answer_episode_url(@game)
    @game.reload
    assert_equal @game.game_state, GameState::QUESTION_ANSWER
    game_player_question_answers = assigns(:game_player_question_answers)
    assert_equal @game_player_six.id, game_player_question_answers[0].game_player_id
    assert_equal @game_player_four.id, game_player_question_answers[1].game_player_id
    assert_equal @game_player_five.id, game_player_question_answers[2].game_player_id
  end

  private

  def player_four_answer(answer)
    sign_in @four
    @game.reload
    patch episodes_player_board_episode_url(@game, { params: { game_question_id: @game.current_game_question_id, game_player_id: @game_player_four.id, answer: answer } })
    sign_in @user
  end

  def player_five_answer(answer)
    sign_in @four
    @game.reload
    patch episodes_player_board_episode_url(@game, { params: { game_question_id: @game.current_game_question_id, game_player_id: @game_player_five.id, answer: answer } })
    sign_in @user
  end

  def player_six_answer(answer)
    sign_in @four
    @game.reload
    patch episodes_player_board_episode_url(@game, { params: { game_question_id: @game.current_game_question_id, game_player_id: @game_player_six.id, answer: answer } })
    sign_in @user
  end
end
