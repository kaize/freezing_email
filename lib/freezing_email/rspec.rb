module FreezingEmail::Rspec
  extend ActiveSupport::Concern

  included do
    before(:all) do
      FreezingEmail::Storage.cleanup
    end

    after(:each) do |example_group|
      dir = FreezingEmail::Config[:store_path]

      ActionMailer::Base.deliveries.each do |mail|
        name ="#{mail.subject.parameterize.tableize}"

        FreezingEmail::Storage.save(name, mail)
      end
    end
  end
end
