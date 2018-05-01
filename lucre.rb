require 'sinatra'
require_relative 'lib/parsimony'


get '/' do
  erb :index
end

post '/' do
  @result = Parsimony.find(params['address'], params['lat'], params['lng'])

  erb :index
end
