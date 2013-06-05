require "yaml"
require "active_support/concern"
require "mail"

require "freezing_email/version"

module FreezingEmail
  autoload 'Rspec', 'freezing_email/rspec'
  autoload 'Config', 'freezing_email/config'
  autoload 'Storage', 'freezing_email/storage'
  autoload 'Mail', 'freezing_email/mail'
  autoload 'Engine', 'freezing_email/engine'
  autoload 'Web', 'freezing_email/web'

  class ConfigEntryNotFound < RuntimeError; end

  class << self
  end
end
