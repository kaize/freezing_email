require "freezing_email/version"
require "active_support/concern"

module FreezingEmail
  autoload 'Rspec', 'freezing_email/rspec'
  autoload 'Config', 'freezing_email/config'

  class << self
  end
end
