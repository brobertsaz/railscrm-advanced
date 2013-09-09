class Opportunity
  include Mongoid::Document
  include Mongoid::Timestamps

  field :opportunity_name
  field :account_name
  field :type
  field :amount
  field :stage
  field :owner
  field :probability
  field :contact_name
  field :comments
  field :closing_date

  validates_presence_of :opportunity_name, :account_name, :owner

  belongs_to :organization


  TYPES  = [['New Customer', 'new_customer'], ['Existing Customer', 'existing_customer']]
  STAGES = [['Prospecting', 'prospecting'], ['Proposal', 'proposal'], ['Analysis', 'analysis'], ['Presentation', 'presentation'], ['Negotiation', 'negotiation'], ['Final Review', 'final_review'], ['Closed/Won','closed_won'], ['Closed/Lost', 'closed_lost']]

  class << self

    def types
      TYPES
    end

    def stages
      STAGES
    end

  end

end
