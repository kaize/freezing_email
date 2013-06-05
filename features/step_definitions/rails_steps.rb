When /^I add "([^"]+)" from this project as a dependency$/ do |gem_name|
  append_to_file('Gemfile', %{gem "#{gem_name}", :path => "#{PROJECT_ROOT}"\n})
end

When /^I add "([^"]+)" as a dependency$/ do |gem_name|
  append_to_file('Gemfile', %{gem "#{gem_name}"\n})
end

And /^I have allready freezed emails in 'freezed_emails' folder$/ do
  create_dir("#{PROJECT_ROOT}/freezed_emails/")

  write_file("#{PROJECT_ROOT}/freezed_emails/password_resets", File.expand_path("../../fixtures/password_resets", __FILE__))
end
