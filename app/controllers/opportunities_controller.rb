class OpportunitiesController < ApplicationController

	def new
		@opportunity 						= current_user.organization.opportunities.new
		@opportunity_owner  	  = current_user.organization.users.map(&:email)
    @opportunity_type		   	= Opportunity.types
    @opportunity_stage  		= Opportunity.stages
    @opportunity_account		= Account.all.map(&:name)
	end

	def create
    @opportunity = current_user.organization.opportunities.new params[:opportunity]
    if @opportunity.save
      redirect_to opportunity_path @opportunity, flash[:notice] = 'New Opportunity Created'
    else
      render :new
    end
  end

  def index
    @opportunities = current_user.organization.opportunities
  end

  def show
		@opportunity 						= current_user.organization.opportunities.find params['id']
		@opportunity_owner  	  = current_user.organization.users.map(&:email)
    @opportunity_type		   	= Opportunity.types
    @opportunity_stage  		= Opportunity.stages
    @opportunity_account		= Account.all.map(&:name)
	end

	def update
    @opportunity = current_user.organization.opportunities.find params[:id]

    if @opportunity.update_attributes params[:opportunity]
      redirect_to opportunity_path @opportunity, flash[:notice] = 'Opportunity Successfully Updated'
    else
      render :edit
    end
  end


  def destroy
    @opportunity = current_user.organization.opportunities.find params[:id]

    if @opportunity.destroy
      flash[:notice] = 'Opportunity Deleted'
      redirect_to :back
    else
      flash[:error] = 'Opportunity could not be deleted'
      redirect_to :back
    end
  end

end
