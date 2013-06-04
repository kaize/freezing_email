class FreezingEmail::Storage
  class << self
    def cleanup
      path = FreezingEmail::Config[:store_path]

      if defined?(Rails)
        path = Rails.root.join(path)
      end

      list = Dir.glob(File.join(path, '/*'))
      FileUtils.rm_rf(list)
    end

    def save(file_name, object)
      File.open(File.join(dir, file_name), 'w') { |f| f.puts YAML::dump(object) }
    end

    def load(file_name)
      file_name = File.join(dir, file_name)
      if File.exists?(file_name)
        YAML::load(IO.read(file_name))
      end
    end

    def dir
      dir = FreezingEmail::Config[:store_path]

      if defined?(Rails)
        dir = Rails.root.join(dir)
      end

      Dir.mkdir(dir) unless Dir.exists?(dir)

      dir
    end
  end
end
