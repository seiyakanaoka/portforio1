module DirectsHelper
  def unchecked_directs
    @directs = current_user.passive_directs.where(checked: false)
  end
end
