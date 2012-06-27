['rubygems', 'require_relative'].each {|g| require g} if RUBY_VERSION =~ /1\.8/
require_relative 'helper'

class LogiTest < Test::Unit::TestCase
  ### Initialization

  def test_initialize
    l = LLRemote::Logi.new(:link => 'a', :title => 'b', :body => 'c')
    assert_equal 'a', l.link
    assert_equal 'b', l.title
    assert_equal 'c', l.body
  end
end
