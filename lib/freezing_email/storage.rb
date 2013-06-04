class FreezingEmail::Storage
  class << self
    def cleanup
      path = FreezingEmail::Config[:store_path]

      if defined?(Rails)
        path = Rails.root.join(path)
      end

      FileUtils.rm_rf(path)
    end

    def save(file_name, object)
      File.open(file_name, 'w') { |f| f.puts YAML::dump(object) }
    end

    def load(file_name)
      if File.exists?(file_name)
        YAML::load(IO.read(file_name))
      end
    end
  end
end
