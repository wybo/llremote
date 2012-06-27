# LogiLogi Remote
  "Your remote control for LogiLogi"

Allows you to update and create Logis on http://www.LogiLogi.org from 
any application.

LLRemote is a library by the LogiLogi Foundation
(http://foundation.logilogi.org).

## Usage

First require it.

  $ irb

  > require 'rubygems'
  > require 'llremote'

First set it up for connecting

  > LLRemote.setup(:access_token => <your API access token>)

Then initialize the remote logi

  > logi = LLRemote::Logi.new(
  >   :link => "Interesting/New",
  >   :title => "My shiny new Logi",
  >   :body => "New things come about...")

And save it.

  > logi.save

It's that easy.

## Installation

Add this line to your application's Gemfile:

    gem 'llremote'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install llremote

Feel free to report issues and to ask questions. For the latest news on
LLRemote:

* http://foundation.logilogi.org/tags/LLRemote

## Contributing

If you wish to contribute, please create a pull-request and remember
to update the corresponding unit test(s).

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
