desc "Heroku scheduler tasks"
task notify_review: :environment do
  puts "Sending out email reminders for review."
  User.notify_review
  puts "Emails sent!"
end
