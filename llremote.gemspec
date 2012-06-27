# -*- encoding: utf-8 -*-
require File.expand_path('../lib/l_l_remote/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors = ['Wybo Wiersma']
  gem.email = ['mail@wybowiersma.net']
  gem.description = 'LogiLogi API wrapper that allows you to update and create Logis on http://www.LogiLogi.org from any application.'
  gem.summary = 'A gem wrapping the LogiLogi API'
  gem.homepage = 'http://github.com/wybo/llremote'

  gem.files = `git ls-files`.split($\)
  gem.test_files = gem.files.grep(%r{^test/test_.*})
  gem.name = 'llremote'
  gem.require_paths = ['lib']
  gem.version = LLRemote::VERSION

  gem.add_dependency 'activeresource'
  gem.add_dependency 'ratom'

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'test-unit'
  gem.add_development_dependency 'require_relative'
end
