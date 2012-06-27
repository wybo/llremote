class LLRemote::Step < ActiveResource::Base
  def self.setup
    self.site = LLRemote.server_url + '/do/'
    self.user = LLRemote.access_token
    self.element_name = 'step'
  end
end
