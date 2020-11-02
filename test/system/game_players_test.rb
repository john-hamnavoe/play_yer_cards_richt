require "application_system_test_case"

class GamePlayersTest < ApplicationSystemTestCase
  setup do
    @game_player = game_players(:one)
  end

  test "visiting the index" do
    visit game_players_url
    assert_selector "h1", text: "Game Players"
  end

  test "creating a Game player" do
    visit game_players_url
    click_on "New Game Player"

    fill_in "Game", with: @game_player.game_id
    fill_in "Total points", with: @game_player.total_points
    fill_in "User", with: @game_player.user_id
    click_on "Create Game player"

    assert_text "Game player was successfully created"
    click_on "Back"
  end

  test "updating a Game player" do
    visit game_players_url
    click_on "Edit", match: :first

    fill_in "Game", with: @game_player.game_id
    fill_in "Total points", with: @game_player.total_points
    fill_in "User", with: @game_player.user_id
    click_on "Update Game player"

    assert_text "Game player was successfully updated"
    click_on "Back"
  end

  test "destroying a Game player" do
    visit game_players_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Game player was successfully destroyed"
  end
end
