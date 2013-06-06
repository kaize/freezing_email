module FreezingEmail::Rspec
  extend ActiveSupport::Concern

  included do
    before(:all) do
      FreezingEmail::Storage.cleanup
    end

    after(:each) do |example_group|
      dir = FreezingEmail::Config[:store_path]

      ActionMailer::Base.deliveries.each do |mail|
        freezing_mail = FreezingEmail::Mail.new(mail, {
          generated_in: example_group.example.description.to_s
        })

        FreezingEmail::Storage.save(freezing_mail.name, freezing_mail)
        puts "FreezingEmail: Saved email #{freezing_mail.name}"
      end
    end
  end
end
