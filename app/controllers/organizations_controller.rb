class OrganizationsController < ApplicationController

  def new
    @organization = Organization.new
  end

  def create
    @organization = Organization.create params[:organization]
    if @organization.save
      @organization.users << current_user
      flash[:notice] = 'Organization successfully created'
      redirect_to :dashboard
    else
      flash[:error] = 'Unable to create organization'
      redirect_to :back
    end
  end

end
