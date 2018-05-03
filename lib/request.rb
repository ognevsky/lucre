require 'ostruct'
require 'httparty'

class Request
  CAPACITY  = 2
  DURATION  = '1_month'
  ROOM_TYPE = 'entire_home_apt'

  include HTTParty
  base_uri 'airbnb.com'

  def initialize(address, lat, lng)
    @options = { query: { room_type: ROOM_TYPE, person_capacity: CAPACITY,
      duration: DURATION, address: address, lat: lat, lng: lng } }
  end

  def wmpw_data
    response = self.class.get('/wmpw_data', @options)['data']
    OpenStruct.new(response)
  end
end
