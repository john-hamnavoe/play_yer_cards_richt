require 'test_helper'

class GamePlayersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    @game = games(:one)
    @game_player = game_players(:four)
  end

  test "should get index" do
    sign_in @user
    get game_players_url
    assert_response :success
  end

  test "should get new" do
    sign_in @user
    get new_game_player_url
    assert_response :success
  end

  test "should create game_player and then not create if already created" do
    three = users(:three)
    sign_in three

    assert_difference('GamePlayer.count') do
      post game_players_url, params: { game_player: { pin: @game.pin } }
    end

    assert_redirected_to episodes_player_board_episode_url(@game.id)

    assert_no_difference('GamePlayer.count') do
      post game_players_url, params: { game_player: { pin: @game.pin } }
    end

    assert_redirected_to episodes_player_board_episode_url(@game.id)
  end

  test "should show game_player" do
    sign_in @user
    get game_player_url(@game_player)
    assert_response :success
  end
end
