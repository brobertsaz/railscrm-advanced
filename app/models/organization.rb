class Organization
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name
  field :phone
  field :address
  field :city
  field :state
  field :zip
  field :max_users, type: Integer, default: 1

  validates_presence_of :name, :phone, :max_users
  validates_uniqueness_of :name

  has_many :users
  has_many :leads
  has_many :accounts
  has_many :contacts
  has_many :opportunities

end
