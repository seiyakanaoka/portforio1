class RanksController < ApplicationController

  def ranking
    @ranking = Log.find(Impression.group(:impressionable_id).order('count(impressionable_id) desc').limit(3).pluck(:impressionable_id))
  end
end
