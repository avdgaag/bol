require 'spec_helper'

describe Bol::Category do
  describe 'combining categories' do
    it 'should add two categories for a combined scope'
    it 'should subtract two categories to reduce scope'
    it 'should manually add category IDs'
  end

  describe '#search' do
    it 'should default to root category from the class' do
      query = Bol::Category.search 'foo'
      query.must_be_kind_of Bol::Query
      query.category_id.must_equal 0
    end

    it 'should set query term' do
      query = Bol::Category.search 'foo'
      query.terms.must_equal 'foo'
    end
  end

  describe 'default category' do
    it 'should set request category scope to 0' do
      Bol::Category.new.id.must_equal(0)
    end
  end

  describe 'lists' do
    let(:cat) { Bol::Category.new.top }

    it 'should create a list request' do
      cat.must_be_instance_of(Bol::Query)
    end

    it 'should be scoped to the category' do
      cat.category_id.must_equal(0)
    end
  end

  describe 'subcategories' do
    let(:cat) { Bol::Category.new.subcategories }

    it 'should create category list request' do
      cat.must_be_instance_of(Bol::Requests::Category)
    end

    it 'should return array of Category objects'
  end

  describe 'finding' do
    it 'should not perform a request using #find'
    it 'should perform a request when accessing the category name'
  end
end
