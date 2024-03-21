class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  def display_image
    # TODO: set host in evn file
    ActiveStorage::Current.set(url_options: { host: "http://localhost:3000" }) do 
      self.image&.url
    end
  end
end
