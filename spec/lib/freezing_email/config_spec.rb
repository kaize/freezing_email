require 'spec_helper'

describe FreezingEmail::Config do
  it 'should set/return value' do
    value = rand(999)
    FreezingEmail::Config[:key] = value
    FreezingEmail::Config[:key].should eq value
  end

  it 'should return default value for store_path' do
    expect { FreezingEmail::Config[:store_path]}.to_not raise_error(FreezingEmail::ConfigEntryNotFound)
  end
end
