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
#
# LLRemote allows you to save logis remotely.

require 'rubygems'
gem 'ratom'
require 'atom'
require 'atom/pub'

$:.unshift(File.dirname(__FILE__)) unless
    $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

class LLRemote
  ### Class-attributes
  
  [:access_token,:server_url].each do |cattribute|
  eval <<FUN
    def self.#{cattribute}
      @@#{cattribute}
    end

    def self.#{cattribute}=(attr)
      @@#{cattribute} = attr
    end
FUN
  end

  ### Class-methods

  # Sets the api-key and other options.
  #
  # Options:
  # * <tt>access_token</tt> = the API key, required
  # * <tt>server_url</tt> = the logilogi server, defaults to
  #   http://en.logilogi.org
  #
  def self.setup(options = {})
    raise 'Needs :access_token' if options[:access_token].nil?

    LLRemote.access_token = options[:access_token]
    if options[:server_url]
      LLRemote.server_url = options[:server_url].gsub(/\/$/,"")
    else
      LLRemote.server_url = "http://en.logilogi.org"
    end
  end

  # Loads a ratom Atom::Entry for the given link.
  #
  # For internal use.
  #
  def self.load_entry(link)
    begin
      return Atom::Entry.load_entry(URI.parse(LLRemote.server_url + link + "/do.xml"))
    rescue
      raise 'Error: Perhaps wrong credentials ?'
    end
  end
end

require 'l_l_remote/logi'
