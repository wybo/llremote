['rubygems', 'require_relative'].each {|g| require g} if RUBY_VERSION =~ /1\.8/
require_relative 'helper'

class LLRemoteTest < Test::Unit::TestCase
  ### Initialization

  def test_initialize
    LLRemote.setup(:access_token => 'Moo', :server_url => 'http://bod.com')
    assert_equal 'Moo', LLRemote.access_token
    assert_equal 'http://bod.com', LLRemote.server_url
  end
end
