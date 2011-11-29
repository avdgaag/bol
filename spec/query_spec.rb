require 'minitest/spec'

describe Bol::Query do
  describe 'category scope' do
    it 'should set category scope'
    it 'should raise unless given a number'
    it 'should set category param'
  end

  describe '#limit' do
    it 'should raise unless given a number'
    it 'should add parameter to request'
    it 'should return query'
  end

  describe '#page' do
    it 'should raise unless given numeric'
    it 'should default to 1'
    it 'should add limit param to request'
    it 'should add offset param to request'
    it 'should use per page config to determine offset value'
    it 'should return query'
  end

  describe '#offset' do
    it 'should raise unless given a number'
    it 'should add parameter to request'
    it 'should return query'
  end

  describe '#order' do
    it 'should convert to string'
    it 'should raise unless wrong format'
    it 'should add order direction on request'
    it 'should add order key on request'
    it 'should return query'
  end
end

