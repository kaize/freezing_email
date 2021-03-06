require 'spec_helper'
require 'tempfile'

describe FreezingEmail::Storage do
  before do
    FreezingEmail::Config[:store_path] = Dir.mktmpdir

    fixtures = Dir[File.expand_path('../../../fixtures/*', __FILE__)]

    objects = FreezingEmail::Config[:store_path]
    FileUtils.cp_r(fixtures, objects)
  end

  it 'should cleanup' do
    Dir.exists?(FreezingEmail::Config[:store_path]).should be true

    FreezingEmail::Storage.cleanup

    files = Dir.glob(File.join(FreezingEmail::Config[:store_path], '/*'))
    files.count.should be 0
  end

  it 'should cleanup by mask' do
    mask = 'mask'

    object = {test: [1, 2, 3, 4]}

    FreezingEmail::Storage.save("#{mask}_password_resets.yml", object)

    FreezingEmail::Storage.cleanup(mask)

    files = Dir.glob(File.join(FreezingEmail::Config[:store_path], '/*'))
    files.count.should be 1
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

  it 'should return list of stored obejcts' do
    objects = FreezingEmail::Storage.index

    objects.first.should be_a_kind_of(FreezingEmail::Mail)
  end

  after do
     FileUtils.remove_entry(FreezingEmail::Config[:store_path])
  end
end
