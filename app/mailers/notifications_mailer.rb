class NotificationsMailer < ApplicationMailer
  def pending_cards(user)
    @user = user
    @cards = user.cards_for_review
    mail(to: @user.email, subject: "Cards review")
  end
end
