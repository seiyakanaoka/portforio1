class HomesController < ApplicationController

  def top
    @logs = Log.all
  end

  def about
  end
end
