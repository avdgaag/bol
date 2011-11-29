require 'minitest/spec'

describe Bol::Product do
  describe '#find' do
    it 'should create new request'
    it 'should not send request'
    it 'should set id param'
    it 'should return product instance'
    it 'should raise error when not found'
  end

  describe 'attributes' do
    it 'should delegate [] to attributes'
    it 'should expose attributes as methods'

    describe 'release date' do
      it 'should parse to a Datetime'
    end

    describe 'cover' do
      it 'should return medium by default'
      it 'should take format as argument'
      it 'should raise on invalid format'
    end
  end
end
