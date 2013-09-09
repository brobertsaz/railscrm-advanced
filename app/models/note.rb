class Note
  include Mongoid::Document
  include Mongoid::Timestamps

  field :content
  field :note_type
  field :due_date, as: "Date"

  validates_presence_of :note_type, :due_date

  belongs_to :lead
end
