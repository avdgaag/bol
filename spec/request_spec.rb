require 'minitest/spec'

describe Bol::Request do
  describe 'category scope' do
    it 'should set category scope'
    it 'should raise when scope is not an id'
    it 'should keep scope across requests'
    it 'should reset scope'
    it 'should add scope as param'
  end

  describe 'signing' do
    it 'should raise error when key and secret are not configured'
    it 'should add signature to request by default'
  end

  describe 'firing' do
    it 'should trigger HTTP request on looping'
    it 'should trigger event manually'
  end

  describe Bol::Requests::Product do
    it 'should get from correct URL'
    it 'should require param id'
    it 'should yield Product'
  end

  describe Bol::Requests::Category do
    it 'should get from correct URL'
    it 'should require param id'
    it 'should yield Category'
  end

  describe Bol::Requests::Search do
    it 'should get from correct URL'
    it 'should require param term'
    it 'should allow key ...'
    it 'should yield Product'
  end

  describe Bol::Requests::List do
    it 'should get from correct URL'
    it 'should require param type'
    it 'should yield Product'
  end
end
