class Episodes::CreatedEpisodesController < ApplicationController
  before_action :authenticate_user!

  def show
    @game = Game.find_by(id: params[:id])
  end
end
