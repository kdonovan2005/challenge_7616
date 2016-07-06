class FilmsController < ApplicationController

  def index
    @films = Film.get_data
    @budget = Film.get_budget
  end

  def show
    @film = Film.find(params[:id])
  end

end
