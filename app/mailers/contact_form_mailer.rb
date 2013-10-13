class ContactFormMailer < ActionMailer::Base
  default from: 'no-reply@railscrm.com'

  def deliver_form(contact)
    @contact = contact
    mail(to: 'broberts_az@yahoo.com', subject: 'Information was requested on RailsCRM')
  end

end