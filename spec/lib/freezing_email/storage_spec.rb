require 'spec_helper'
require 'tempfile'

describe FreezingEmail::Storage do
  before do
    FreezingEmail::Config[:store_path] = Dir.mktmpdir
  end

  it 'should cleanup' do
    Dir.exists?(FreezingEmail::Config[:store_path]).should be true

    File.open(File.join(FreezingEmail::Config[:store_path], 'test'), 'w') { |f| f.puts 'test' }

    FreezingEmail::Storage.cleanup

    files = Dir.glob(File.join(FreezingEmail::Config[:store_path], '/*'))
    files.count.should be 0
  end

  it 'should save/load object' do
    t_file = 'freezing_email_test'

    object = {
      test: [1, 2, 3, 4]
    }

    FreezingEmail::Storage.save(t_file, object)
    loaded_object = FreezingEmail::Storage.load(t_file)

    loaded_object.should eq object
  end

  after do
     FileUtils.remove_entry(FreezingEmail::Config[:store_path])
  end
end
