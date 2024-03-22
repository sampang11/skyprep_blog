class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  def display_image
    # TODO: set host in evn file
    ActiveStorage::Current.set(url_options: { host: "http://localhost:3000" }) do 
      self.image&.url
    end
  end

  def sentiment_analysis
    Rails.cache.fetch("sentiment_analysis:#{id}") do
      SentimentAnalysis.new(content).analyze
    end
  end

  def sentiment_in_text
    sentiments = {
      "P+" => "strong positive",
      "P"  => "positive",
      "Neu"=> "neutral",
      "N"  => "negative",
      "N+" => "strong negative",
      "NONE" => "without polarity"
    }

    sentiments.fetch(sentiment_analysis, "no sentiment detected")
  end
end
