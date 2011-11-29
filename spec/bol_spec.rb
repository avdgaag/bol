require 'minitest/spec'
require 'bol'

describe Bol do
  describe '#configure' do
    it 'should create configuration object'
    it 'should yield config object without argument'
    it 'should raise with non-hash argument'
    it 'should not yield with argument'
  end

  describe '#products' do
    it 'should delegate to new empty category products'
  end

  describe '#search' do
    it 'should delegate to new empty category search'
  end
end
