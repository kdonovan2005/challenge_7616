class FilmsController < ApplicationController

  def index
    @films = Film.get_data
    @film = Film.create
  end

end
