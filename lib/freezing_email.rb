require "yaml"
require "freezing_email/version"
require "active_support/concern"


module FreezingEmail
  autoload 'Rspec', 'freezing_email/rspec'
  autoload 'Config', 'freezing_email/config'
  autoload 'Storage', 'freezing_email/storage'

  class ConfigEntryNotFound < RuntimeError; end

  class << self
  end
end
