class UsersController < ApplicationController

  def dashboard
    @leads = Lead.all.where(lead_owner: current_user.email).to_a
    @tasks = Task.all.where(assigned_to: current_user.email).to_a
  end
end
