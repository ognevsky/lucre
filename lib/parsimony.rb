require 'httparty'
require 'ostruct'

class Parsimony
  attr_reader :address, :lat, :lng

  def self.find(address, lat, lng)
    new(address, lat, lng).()
  end

  def initialize(address, lat, lng)
    @address = address
    @lat = lat
    @lng = lng
  end

  def call
    Request.new(address, lat, lng).wmpw_data
  end

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
      puts response.inspect
      Response.new(response)
    end
  end

  class Response < OpenStruct; end
end
