require "open-uri"
require "nokogiri"

SOURCE_URL = "https://quizlet.com/50590/1000-top-used-spanish-words-flash-cards"
ORIGINAL_CSS_SELECTOR = "h3"
TRANSLATED_CSS_SELECTOR = "p"

html = open(SOURCE_URL)
document = Nokogiri::HTML(html.read, "utf-8")

rows = document.css("article.terms").css("div.term").css("div.text")[1..10]

user = User.create(email: "justcxx@gmail.com", password: "qweasd")
deck = user.decks.create(title: "SeedDeck")

rows.each do |row|
  card = {
    original_text: row.css(ORIGINAL_CSS_SELECTOR).text,
    translated_text: row.css(TRANSLATED_CSS_SELECTOR).text
  }

  card.each { |k, v| card[k] = v.strip.tr('"', "") }

  card = deck.cards.new ({
    original_text: card[:original_text],
    translated_text: card[:translated_text]
  })
  card.save
end
