require 'spec_helper'

describe Bol::Configuration do
  describe 'as a hash' do
    it 'should should set known keys' do
      c = Bol::Configuration.new access_key: 'foo'
      c[:access_key].must_equal 'foo'
    end

    it 'should raise for unknown keys' do
      proc { Bol::Configuration.new foo: 'bar' }.must_raise ArgumentError
    end

    it 'should set a single key' do
      c = Bol::Configuration.new
      c[:access_key] = 'bar'
      c[:access_key].must_equal 'bar'
    end
  end

  describe 'as attributes' do
    let(:config) { Bol::Configuration.new }

    it 'should should set known keys' do
      config.access_key = 'bar'
      config.access_key.must_equal 'bar'
    end

    it 'should raise for unknown keys' do
      proc { config.foo = 'bar' }.must_raise NoMethodError
      proc { config.foo }.must_raise NoMethodError
    end
  end
end
