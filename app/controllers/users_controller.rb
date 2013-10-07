class UsersController < ApplicationController

  def dashboard
    @leads = Lead.all.where(lead_owner: current_user.email).to_a
    @tasks = Task.all.where(assigned_to: current_user.email).to_a
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.save
      redirect_to :back, notice: 'Updated user'
    end
  end
end
