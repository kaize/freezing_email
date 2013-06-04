require 'spec_helper'
require 'tempfile'

describe FreezingEmail::Storage do
  it 'should cleanup' do
    Dir.mkdir FreezingEmail::Config[:store_path]
    Dir.exists?(FreezingEmail::Config[:store_path]).should be true

    FreezingEmail::Storage.cleanup

    Dir.exists?(FreezingEmail::Config[:store_path]).should be false
  end

  it 'should save/load object' do
    t_file = Tempfile.new('freezing_email_test.tmp')

    object = {
      test: [1, 2, 3, 4]
    }

    FreezingEmail::Storage.save(t_file, object)
    loaded_object = FreezingEmail::Storage.load(t_file)

    loaded_object.should eq object

    File.unlink(t_file)
  end
end
