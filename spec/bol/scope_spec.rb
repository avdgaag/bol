require 'spec_helper'

describe Bol::Scope do
  describe 'combining categories' do
    it 'should add two categories for a combined scope' do
      cat = Bol::Scope.new(1) + Bol::Scope.new(2)
      cat.id.should == '1+2'
    end

    it 'should not duplicate IDs when adding' do
      cat = Bol::Scope.new(1) + Bol::Scope.new(2) + Bol::Scope.new(2)
      cat.id.should == '1+2'
    end

    it 'should subtract two categories to reduce scope' do
      a = Bol::Scope.new(1) + Bol::Scope.new(2)
      b = Bol::Scope.new(2)
      (a - b).id.should == '1'
    end
  end

  describe '#search' do
    it 'should default to root category from the class' do
      query = Bol::Scope.new.search 'foo'
      query.should be_instance_of Bol::ResultProxy
      query.category_id.should == 0
    end

    it 'should set query term' do
      Bol::Requests::Search.should_receive(:new).with(instance_of(Bol::Query)).and_return(stub(proxy: nil, query: nil))
      Bol::Scope.new.search 'foo'
    end
  end

  describe 'default category' do
    it 'should set request category scope to 0' do
      Bol::Scope.new.id.should == 0
    end
  end

  describe 'lists' do
    let(:cat) { Bol::Scope.new.top_products }

    it 'should create a list request' do
      cat.should be_instance_of Bol::ResultProxy
    end

    it 'should be scoped to the category' do
      cat.category_id.should == 0
    end
  end

  describe 'subcategories' do
    let(:cat) { Bol::Scope.new.subcategories }

    it 'should create category list request' do
      cat.should be_instance_of Bol::Requests::Category
    end
  end
end
