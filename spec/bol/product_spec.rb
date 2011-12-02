require 'spec_helper'

describe Bol::Product do
  describe '#find' do
    let(:r) { Bol::Product.find(1) }
    it 'should create new request' do
      r.must_be_instance_of(Bol::Requests::Product)
    end

    it 'should set id param' do
      Bol::Requests::Product.expects(:new).with(1, instance_of(Bol::Query))
      Bol::Product.find(1)
    end

    it 'should return product instance'
    it 'should raise error when not found'
  end

  describe 'attributes' do
    it 'should delegate [] to attributes' do
      product = Bol::Product.new
      product.attributes[:foo] = 'bar'
      product[:foo].must_equal('bar')
    end

    it 'should expose attributes as methods' do
      product = Bol::Product.new
      product.attributes[:foo] = 'bar'
      product.foo.must_equal('bar')
    end

    describe 'release date' do
      it 'should parse to a Datetime'
    end

    describe '#cover' do
      it 'should return medium by default'
      it 'should take format as argument'
      it 'should raise on invalid format'
    end
  end
end
