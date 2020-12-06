// Visit The Stimulus Handbook for more details 
// https://stimulusjs.org/handbook/introduction
// 
// This example controller works with specially annotated HTML like:
//
// <div data-controller="hello">
//   <h1 data-target="hello.output"></h1>
// </div>

import { Controller } from "stimulus"
import Rails from "@rails/ujs";

export default class extends Controller {
  static targets = [ "answervalue", "answerbox" ]

  connect() {
  }

  submit(event) {
    const game_id = event.target.dataset.gameId;
    const game_question_id = event.target.dataset.gameQuestionId;
    const game_player_id = event.target.dataset.gamePlayerId;
    const answer = this.answervalueTarget.value

    if (answer)
    {
      console.log("submit:")
      console.log("submit:", game_question_id)
      console.log("submit:", game_player_id)
      console.log("submit:", answer)
      const data = new FormData();
      data.append('[game_question_id]', game_question_id);
      data.append('[game_player_id]', game_player_id);
      data.append('[answer]', answer);
      console.log(game_id)
      Rails.ajax({
        url: '/episodes/player_board_episodes/:id'.replace(':id', game_id),
        type: 'PATCH',
        data,
        success: (data) => {
          this.answerboxTarget.innerHTML = `<h2 class="text-success">Your Answer Has Been Submitted. Good Luck! The Quizmaster will reveal the answer soon.</h2>`
        }
      });      
    }
  }
}
