class FreezingEmail::Storage
  class << self
    def cleanup(mask = "")
      FileUtils.rm_rf(files_list(mask))
    end

    def index
      emails = []

      files_list.each do |file|
        emails << load(file)
      end

      emails
    end

    def save(name, object)
      File.open(expand_name(name), 'w') { |f| f.puts YAML::dump(object) }
    end

    def load(name)
      file_name = expand_name(name)
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

    private

    def files_list(mask = "")
      Dir.glob(File.join(dir, "#{mask}*.yml"))
    end

    def expand_name(name)
      name = File.join(dir, "#{File.basename(name)}")
      name = "#{name}.yml" unless File.extname(name) == ".yml"
      name
    end
  end
end
