require 'spec_helper'

describe Bol do
  describe '#configure' do
    it 'should create configuration object' do
      Bol.configure access_key: 'foo'
      Bol.configuration.access_key.must_equal('foo')
    end

    it 'should yield config object without argument' do
      Bol.configure do |c|
        c.must_equal Bol.configuration
      end
    end

    it 'should raise with non-hash argument' do
      proc { Bol.configure 'foo' }.must_raise ArgumentError
    end

    it 'should not yield with argument' do
      Bol.configure(access_key: 'foo') { |c| flunk }
    end
  end

  describe '#products' do
    it 'should delegate to new empty category products'
  end

  describe '#search' do
    it 'should delegate to new empty category search'
  end
end
