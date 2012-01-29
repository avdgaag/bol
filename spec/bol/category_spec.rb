require 'spec_helper'

describe Bol::Category do
  describe 'combining categories' do
    it 'should add two categories for a combined scope' do
      cat = Bol::Category.new(1) + Bol::Category.new(2)
      cat.id.should == '1+2'
    end

    it 'should not duplicate IDs when adding' do
      cat = Bol::Category.new(1) + Bol::Category.new(2) + Bol::Category.new(2)
      cat.id.should == '1+2'
    end

    it 'should subtract two categories to reduce scope' do
      a = Bol::Category.new(1) + Bol::Category.new(2)
      b = Bol::Category.new(2)
      (a - b).id.should == '1'
    end
  end

  describe '#search' do
    it 'should default to root category from the class' do
      query = Bol::Category.search 'foo'
      query.should be_instance_of Bol::ResultProxy
      query.category_id.should == 0
    end

    it 'should set query term' do
      Bol::Requests::Search.should_receive(:new).with(instance_of(Bol::Query)).and_return(stub(proxy: nil, query: nil))
      Bol::Category.search 'foo'
    end
  end

  describe 'default category' do
    it 'should set request category scope to 0' do
      Bol::Category.new.id.should == 0
    end
  end

  describe 'lists' do
    let(:cat) { Bol::Category.new.top_products }

    it 'should create a list request' do
      cat.should be_instance_of Bol::ResultProxy
    end

    it 'should be scoped to the category' do
      cat.category_id.should == 0
    end
  end

  describe 'subcategories' do
    let(:cat) { Bol::Category.new.subcategories }

    it 'should create category list request' do
      cat.should be_instance_of Bol::Requests::Category
    end
  end
end
