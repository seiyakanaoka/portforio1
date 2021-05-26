class RanksController < ApplicationController
  def index
    @ranking = Log.includes(:user).find(Impression.group(:impressionable_id).order('count(impressionable_id) desc').limit(3).pluck(:impressionable_id))
  end

  def search
    @logs = Log.where('title LIKE(?)', "%#{params[:log][:keyword]}%")
  end
end
