#--#
# Copyright: (c) 2006-2012 Wybo Wiersma <mail@wybowiersma.net>
#
# MIT Licensed
#++#
#
# LLRemote allows you to save logis remotely.

require 'rubygems'
require 'atom'
require 'atom/pub'
require 'active_resource'
require 'l_l_remote/version'

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
      LLRemote.server_url = options[:server_url].gsub(/\/$/,'')
    else
      LLRemote.server_url = 'http://en.logilogi.org'
    end
    LLRemote::Path.setup
    LLRemote::Step.setup
  end

  # Loads a ratom Atom::Entry for the given link.
  #
  # For internal use.
  #
  def self.load_entry(link)
    begin
      return Atom::Entry.load_entry(URI.parse(LLRemote.server_url + '/' + 
          link + '/do.xml'), :read_timeout => 60)
    rescue
      raise 'Error: Can\'t load: ' + link + '. Perhaps wrong link ?'
    end
  end
end

require 'l_l_remote/logi'
require 'l_l_remote/path'
require 'l_l_remote/step'
