class ApplicationMailer < ActionMailer::Base
  default from: "oh-my-flashcards <#{ENV['SMTP_USER']}>"
  layout "mailer"
end
