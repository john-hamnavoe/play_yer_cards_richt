require "application_system_test_case"

class GameQuestionsTest < ApplicationSystemTestCase
  setup do
    @game_question = game_questions(:one)
  end

  test "visiting the index" do
    visit game_questions_url
    assert_selector "h1", text: "Game Questions"
  end

  test "creating a Game question" do
    visit game_questions_url
    click_on "New Game Question"

    fill_in "Card deck", with: @game_question.card_deck
    fill_in "Current card", with: @game_question.current_card
    fill_in "Game", with: @game_question.game_id
    fill_in "Question", with: @game_question.question_id
    click_on "Create Game question"

    assert_text "Game question was successfully created"
    click_on "Back"
  end

  test "updating a Game question" do
    visit game_questions_url
    click_on "Edit", match: :first

    fill_in "Card deck", with: @game_question.card_deck
    fill_in "Current card", with: @game_question.current_card
    fill_in "Game", with: @game_question.game_id
    fill_in "Question", with: @game_question.question_id
    click_on "Update Game question"

    assert_text "Game question was successfully updated"
    click_on "Back"
  end

  test "destroying a Game question" do
    visit game_questions_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Game question was successfully destroyed"
  end
end
