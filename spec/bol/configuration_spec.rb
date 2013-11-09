require 'spec_helper'

describe Bol::Configuration do
  describe 'as a hash' do
    it 'should should set known keys' do
      c = Bol::Configuration.new access_key: 'foo'
      c[:access_key].should == 'foo'
    end

    it 'should raise for unknown keys' do
      expect { Bol::Configuration.new foo: 'bar' }.to raise_error
    end

    it 'should set a single key' do
      c = Bol::Configuration.new
      c[:access_key] = 'bar'
      c[:access_key].should == 'bar'
    end
  end

  describe 'validation' do
    it 'should raise error when not properly configured' do
      c = Bol::Configuration.new
      expect { c.validate }.to raise_error
    end

    it 'should not raise error when all keys are configured' do
      c = Bol::Configuration.new access_key: 'foo', secret: 'bar'
      expect { c.validate }.to_not raise_error
    end
  end

  describe 'as attributes' do
    let(:config) { Bol::Configuration.new }

    it 'should should set known keys' do
      config.access_key = 'bar'
      config.access_key.should == 'bar'
    end

    it 'should raise for unknown keys' do
      expect { config.foo = 'bar' }.to raise_error NoMethodError
      expect { config.foo }.to raise_error NoMethodError
    end
  end
end
