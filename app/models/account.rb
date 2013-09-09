class Account
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name
  field :email
  field :assigned_to
  field :website
  field :phone
  field :address
  field :city
  field :state
  field :zip

  validates_presence_of :name, :phone
  validates :name, uniqueness: true
  belongs_to :organization

end
