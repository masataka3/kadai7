class Map < ApplicationRecord
 after_validation :geocode

  private
  def geocode
    uri = URI.escape("https://maps.googleapis.com/maps/api/geocode/json?address="+self.address.gsub(" ", "")+"&key=[AIzaSyCCHCaSYhX2s0RFQ9ewL9tzSQWtLYzz4hk]")
    res = HTTP.get(uri).to_s
    response = JSON.parse(res)
    self.latitude = response["results"][0]["geometry"]["location"]["lat"]
    self.longitude = response["results"][0]["geometry"]["location"]["lng"]
  end
end