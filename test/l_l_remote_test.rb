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

class LLRemoteTest < Test::Unit::TestCase
  ### Initialization

  def test_initialize
    LLRemote.setup(:access_token => "Moo", :server_url => "http://bod.com")
    assert_equal "Moo", LLRemote.access_token
    assert_equal "http://bod.com", LLRemote.server_url
  end
end
