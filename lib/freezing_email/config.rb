class FreezingEmail::Config
  class << self
    @@defaults = {
      store_path: "freezed_emails"
    }

    def [](key)
      raise FreezingEmail::ConfigEntryNotFound unless key_exists?(key) || defaults_exists?(key)

      if key_exists?(key)
        @config[key]
      else
        @@defaults[key]
      end
    end

    def key_exists?(key)
      @config && @config.has_key?(key)
    end

    def defaults_exists?(key)
      @@defaults.has_key?(key)
    end


    def []=(key, value)
      @config ||= {}
      @config[key] = value
    end
  end
end
