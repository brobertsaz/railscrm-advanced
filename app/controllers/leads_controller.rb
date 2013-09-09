class LeadsController < ApplicationController
  before_filter :authenticate_user!, :except => ['external_form']

  def new
    @lead           = current_user.organization.leads.new
    @lead_owner     = current_user.organization.users.map(&:email)
    @lead_status    = Lead.status
    @lead_sources   = Lead.sources
    @lead_interests = Lead.interests
  end

  def create
    @lead = current_user.organization.leads.new params[:lead]
    @lead.update_attributes(assigned_to: @lead.lead_owner)
    if @lead.save
      current_user.organization.leads << @lead
      LeadMailer.notify_new_lead(@lead.lead_owner, @lead).deliver
      redirect_to lead_path @lead, flash[:notice] = 'New Lead Created'
    else
      render :new
    end
  end

  def index
    @leads = current_user.organization.leads
  end

  def show
    @lead           = current_user.organization.leads.find params[:id]
    @lead_owner     = current_user.organization.users.map(&:email)
    @lead_status    = Lead.status
    @lead_sources   = Lead.sources
    @lead_interests = Lead.interests
  end

  def edit
  end

  def update
    @lead = current_user.organization.leads.find params[:id]
    if params[:commit] == 'Convert'
      convert_lead
    else
      if @lead.update_attributes params[:lead]
        LeadMailer.notify_updated_lead(@lead.lead_owner, @lead).deliver
        redirect_to lead_path @lead, flash[:notice] = 'Lead Updated'
      else
        render :edit
      end
    end
  end

  def destroy
    @lead = Lead.find params[:id]

    if @lead.destroy
      flash[:notice] = 'Lead Deleted'
      redirect_to :back
    else
      flash[:error] = 'Lead could not be deleted'
      redirect_to :back
    end
  end

  def convert
    @lead               = current_user.organization.leads.find params[:id]
    @accounts           = current_user.organization.accounts.all.map(&:name)
    @opportunity_owner  = current_user.organization.users.map(&:email)
  end

  def convert_lead
    @lead = current_user.organization.leads.find params[:id]
    @lead.update_attributes params[:lead]
    @account = current_user.organization.accounts.where(name: params['account_name']).first
    @contacts = current_user.organization.contacts.all.map(&:email)
    unless @contacts.include? @lead.email
      @contact = current_user.organization.contact.create params['lead']
    end
    @opportunities = current_user.organization.opportunities.all.map(&:opportunity_name)
    unless @opportunities.include? @lead.opportunity_name
      @opportunity = current_user.organization.opportunities.create(opportunity_name: @lead.opportunity_name, account_name: @lead.account_name, owner: @lead.opportunity_owner)
    end
    flash[:notice] = 'Lead has been converted'
    redirect_to opportunity_path(@opportunity)
  end

  def new_web_lead
    leads = Lead.new
    minus_lead = ["_type","_id","created_at", "updated_at", "lead_source", "lead_status","lead_owner", "account_name","opportunity_name","opportunity_owner","assigned_to_id", "interested_in"]
    lead = leads.attribute_names.to_a
    @lead = lead-minus_lead
  end

  def create_web_lead
    @in_lead = []
    default_url = "http://demo.railscrm.com" #CHANGE THIS TO A VALID URL
    fields = ["first_name","last_name", "email", "company", "phone", "address", "city", "state", "zip", "comments"]
    fields.each do |field|
      if params["#{field}"].present?
        @in_lead << field
      end
    end
    @value=""
    @required="required"
    @lead_owner = encrypt(current_user.email)
    @redirect_url = params[:redirect_url].empty? ? default_url : params[:redirect_url]
    render "web_form"
  end

  def external_form
    email = decrypt(params[:lead_owner])
    user = User.where(:email =>email).first
    requestor = "#{request.protocol}#{request.fullpath}"
    if user.nil?
      redirect_to requestor
    else
      redirect_url = params[:redirect_url]
      leads = params[:params].split(" ")
      @lead = Lead.new
      leads.each do |lead|
        @lead.update_attribute("#{lead}", params["#{lead}"])
      end
      @lead.update_attributes(:lead_owner => email,:lead_source => requestor)
      if @lead.save!
        LeadMailer.notify_web_form_lead(@lead.lead_owner, @lead).deliver
        redirect_to redirect_url
      end
    end
  end

  private
    def encrypt(data)
      return encrypted_data = KEY.enc(data)
    end

    def decrypt(encrypted_data)
      return data = KEY.dec(encrypted_data)
    end

end