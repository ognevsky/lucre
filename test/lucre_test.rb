require_relative 'test_helper.rb'

class LucreTest < MiniTest::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_get_homepage
    get '/'

    assert last_response.ok?
  end

  def test_post_homepage
    mock = Minitest::Mock.new

    mock.expect :market, 'Prague'
    mock.expect :average_income, '$1000'

    Parsimony.stub :find, mock do
      post '/'
    end

    assert last_response.ok?
    assert_mock mock
  end
end
