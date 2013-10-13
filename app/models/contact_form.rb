class ContactForm < MailForm::Base
  attribute :name,      :validate => true
  attribute :email,     :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :request_type
  attribute :message
  attribute :nickname,  :captcha  => true
  validates_presence_of :email

  # Declare the e-mail headers. It accepts anything the mail method
  # in ActionMailer accepts.
  def headers
    {
      :subject => "Request Info Form",
      :to => "broberts_az@yahoo.com",
      :from => %("#{name}" <#{email}>)
    }
  end
end