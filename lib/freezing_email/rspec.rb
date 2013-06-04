module FreezingEmail::Rspec
  extend ActiveSupport::Concern

  included do
    before(:all) do
      FreezingEmail::Storage.cleanup
    end

    after(:each) do |example_group|
      dir = FreezingEmail::Config[:store_path]

      Dir.mkdir(notifications_dir) unless Dir.exists?(notifications_dir)

      ActionMailer::Base.deliveries.each do |mail|
        filename ="#{mail.subject.parameterize.tableize}.html"
        file_name = File.join(notifications_dir, filename)
        File.open(file_name, 'w') { |f| f.puts YAML::dump(mail) }
      end
    end
  end
end
