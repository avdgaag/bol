require 'spec_helper'

describe Bol::Query do
  describe 'category scope' do
    it 'should set category scope' do
      Bol::Query.new(1).category_id.must_equal(1)
    end

    it 'should raise unless given a number' do
      proc { Bol::Query.new('foo') }.must_raise ArgumentError
    end

    it 'should set category param' do
      Bol::Query.new(1).params[:categoryId].must_equal(1)
    end
  end

  describe '#has_param?' do
    let(:q) { Bol::Query.new(0) }

    it 'should be true when object' do
      q.has_param?(:categoryId).must_equal true
    end

    it 'should be false when nil' do
      q.has_param?(:term).must_equal false
    end

    it 'should be false when not set' do
      q.has_param?(:foo).must_equal false
    end
  end

  describe '#limit' do
    let(:q) { Bol::Query.new(0) }

    it 'should parse argument to a number' do
      q.limit('10').limit.must_equal(10)
    end

    it 'should add parameter to request' do
      q.limit(10)
      q.params[:nrProducts].must_equal(10)
    end

    it 'should not add parameter when not set' do
      q.params.keys.wont_include(:nrProducts)
    end

    it 'should return query' do
      q.limit(10).must_equal(q)
    end
  end

  describe '#page' do
    let(:q) { Bol::Query.new(0).page(2) }

    it 'should parse to number' do
      Bol::Query.new(0).page('2').limit.must_equal(10)
    end

    it 'should default to 1' do
      x = Bol::Query.new(0).page(nil)
      x.limit.must_equal(10)
      x.offset.must_equal(0)
    end

    it 'should add limit param to request' do
      q.limit.must_equal(10)
    end

    it 'should add offset param to request' do
      q.offset.must_equal(10)
    end

    it 'should use per page config to determine offset value' do
      Bol.configuration[:per_page] = 20
      x = Bol::Query.new(0).page(3)
      x.limit.must_equal(20)
      x.offset.must_equal(40)
      Bol.configuration[:per_page] = 10
    end

    it 'should return query' do
      q = Bol::Query.new(0)
      q.page(1).must_equal(q)
    end
  end

  describe '#offset' do
    let(:q) { Bol::Query.new(0) }

    it 'should parse argument to a number' do
      q.offset('10').offset.must_equal(10)
    end

    it 'should add parameter to request' do
      q.offset(10)
      q.params[:offset].must_equal(10)
    end

    it 'should not add parameter when not set' do
      q.params.keys.wont_include(:offset)
    end

    it 'should return query' do
      q.offset(10).must_equal(q)
    end
  end

  describe '#order' do
    let(:q) { Bol::Query.new(0) }

    it 'should raise unless wrong format' do
      proc { q.order('foo') }.must_raise ArgumentError
    end

    it 'should add order direction on request' do
      q.order('price ASC').params[:sortingAscending].must_equal('true')
      q.order('price DESC').params[:sortingAscending].must_equal('false')
    end

    it 'should add order key on request' do
      q.order('price ASC').params[:sortingMethod].must_equal('price')
    end

    it 'should return query' do
      q.order('price ASC').must_equal(q)
    end
  end
end

