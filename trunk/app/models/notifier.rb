class Notifier < ActionMailer::Base

  def activation_instructions(user)
    subject       "MakeOne Activation Instructions"
    from          "MakeOne Notifier noreply@makeone.com"
    recipients    user.email
    sent_on       Time.now
    body          :name => user.login, :account_activation_url => register_url(user.perishable_token)
    content_type  "text/html"
  end
 
  def activation_confirmation(user)
    subject       "MakeOne Activation Complete"
    from          "MakeOne Notifier noreply@makeone.com"
    recipients    user.email
    sent_on       Time.now
    body          :name => user.login, :root_url => root_url
    content_type  "text/html"
  end

end
