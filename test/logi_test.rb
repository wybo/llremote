#--#
# Copyright: (c) 2009 The LogiLogi Foundation <foundation@logilogi.org>
#
# License:
#   This file is part of the LLRemote Library. LLRemote is Free 
#   Software. You can run/distribute/modify LLRemote under the terms 
#   of the GNU Lesser General Public License version 3. This license
#   states that you can use LLRemote in applications that are not Free 
#   Software but LLRemote itself remains Free Software. (LICENSE contains 
#   the full text of the legally binding license).
#++#

require File.dirname(__FILE__) + '/test_helper.rb'

class LogiTest < Test::Unit::TestCase
  ### Initialization

  def test_initialize
    l = LLRemote::Logi.new(:link => "a", :title => "b", :body => "c")
    assert_equal "a", l.link
    assert_equal "b", l.title
    assert_equal "c", l.body
  end
end
