class UserMailer < ActionMailer::Base
  default from: 'no-reply@railscrm.com'

  def reset_password(user)
    @user = user
    mail(to: @user.email, subject: 'Password Reset')
  end

  def notify_approval(user)
    @user = user
    mail(to: @user.email, subject: 'RailsCRM Approval')
  end

end
