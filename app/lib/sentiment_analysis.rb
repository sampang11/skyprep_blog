require 'net/http'
require 'uri'

class SentimentAnalysis
  attr_accessor :text, :host_url, :api_key

  def initialize(text)
    @text = text
    @host_url = Rails.application.credentials.meaning_cloud.host_url
    @api_key = Rails.application.credentials.meaning_cloud.api_key
  end

  def analyze
    encoded_text = URI.encode_www_form_component(text)
  
    url = URI("#{host_url}?key=#{api_key}&lang=en&txt=#{encoded_text}")
  
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
  
    request = Net::HTTP::Get.new(url)  
    response = https.request(request)
    return JSON.parse(response.read_body).dig('score_tag')
  rescue StandardError => e
    return nil
  end
end
