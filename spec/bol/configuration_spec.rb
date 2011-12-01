require 'spec_helper'

describe Bol::Configuration do
  describe 'as a hash' do
    it 'should should set known keys' do
      c = Bol::Configuration.new key: 'foo'
      c[:key].must_equal 'foo'
    end

    it 'should raise for unknown keys' do
      proc { Bol::Configuration.new foo: 'bar' }.must_raise ArgumentError
    end

    it 'should set a single key' do
      c = Bol::Configuration.new
      c[:key] = 'bar'
      c[:key].must_equal 'bar'
    end
  end

  describe 'as attributes' do
    let(:config) { Bol::Configuration.new }

    it 'should should set known keys' do
      config.key = 'bar'
      config.key.must_equal 'bar'
    end

    it 'should raise for unknown keys' do
      proc { config.foo = 'bar' }.must_raise NoMethodError
      proc { config.foo }.must_raise NoMethodError
    end
  end
end
