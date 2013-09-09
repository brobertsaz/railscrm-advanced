class Organization
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name
  field :phone
  field :address
  field :city
  field :state
  field :zip

  has_many :users
  has_many :leads
  has_many :accounts
  has_many :contacts
  has_many :opportunities

end
