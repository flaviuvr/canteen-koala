class ApplicationMailer < ActionMailer::Base
  default from: 'hello@koala.com'
  layout 'mailer'
end
