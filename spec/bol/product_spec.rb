require 'spec_helper'

describe Bol::Product do
  describe '#find' do
    let(:r) { Bol::Product.find(1) }

    before do
      Bol.stubs(:configuration).returns({ access_key: 'foo', secret: 'bar' })
      FakeWeb.register_uri(:get, 'https://openapi.bol.com/openapi/services/rest/catalog/v3/products/1?categoryId=0', body: fixture('products.xml'))
    end

    it 'should return product instance' do
      r.must_be_instance_of Bol::Product
    end

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

    describe 'referral_url' do
      let(:product) { Bol::Product.new }

      before do
        product.attributes[:url]   = 'http://foo.bar'
        product.attributes[:id]    = 'qux'
        product.attributes[:title] = 'bla'
      end

      it 'should generate referral URL' do
        product.referral_url('foo').must_equal("http://partnerprogramma.bol.com/click/click?p=1&t=url&s=foo&url=http%3A%2F%2Ffoo.bar&f=API&subid=qux&name=bla")
      end
    end

    describe '#cover' do
      let(:product) { Bol::Product.new }
      before do
        product.attributes[:cover] = {
          medium: 'foo',
          small: 'bar'
        }
      end

      it 'should return medium by default' do
        product.cover.must_equal('foo')
      end

      it 'should take format as argument' do
        product.cover(:small).must_equal('bar')
      end

      it 'should raise on invalid format' do
        proc { product.cover(:baz) }.must_raise(KeyError)
      end
    end
  end
end
