class HomesController < ApplicationController

  def top
    @logs = Log.all
  end

end
