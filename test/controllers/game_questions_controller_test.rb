require 'test_helper'

class GameQuestionsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    sign_in @user
    @game_question = game_questions(:one)
  end

  test "should get index" do
    get game_questions_url
    assert_response :success
  end

  test "should get new" do
    get new_game_question_url
    assert_response :success
  end

  test "should create game_question" do
    assert_difference('GameQuestion.count') do
      post game_questions_url, params: { game_question: { card_deck: @game_question.card_deck, current_card: @game_question.current_card, game_id: @game_question.game_id, question_id: @game_question.question_id } }
    end

    assert_redirected_to game_question_url(GameQuestion.last)
  end

  test "should show game_question" do
    get game_question_url(@game_question)
    assert_response :success
  end

  test "should get edit" do
    get edit_game_question_url(@game_question)
    assert_response :success
  end

  test "should update game_question" do
    patch game_question_url(@game_question), params: { game_question: { card_deck: @game_question.card_deck, current_card: @game_question.current_card, game_id: @game_question.game_id, question_id: @game_question.question_id } }
    assert_redirected_to game_question_url(@game_question)
  end
end
