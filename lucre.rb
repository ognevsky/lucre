require 'sinatra'
require_relative './lib/request'

get '/' do
  erb :index
end

post '/' do
  @result = Request.new(params['address'], params['lat'], params['lng']).wmpw_data

  erb :index
end
