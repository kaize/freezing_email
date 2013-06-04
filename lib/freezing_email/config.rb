class FreezingEmail::Config
  class << self
    @@defaults = {
      store_path: "freezed_emails"
    }

    def [](key)
      raise ConfigEntryNotFound unless @config && @config.has_key?(key)

      @config[key]
    end

    def []=(key, value)
      @config ||= {}
      @config[key] = value
    end
  end
end
