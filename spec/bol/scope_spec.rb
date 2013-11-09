require 'spec_helper'

describe Bol::Scope do
  describe 'combining categories' do
    it 'should add two categories for a combined scope' do
      cat = Bol::Scope.new(1) + Bol::Scope.new(2)
      cat.ids.should == [1, 2]
    end

    it 'should not duplicate IDs when adding' do
      cat = Bol::Scope.new(1) + Bol::Scope.new(2) + Bol::Scope.new(2)
      cat.ids.should == [1,2]
    end

    it 'should subtract two categories to reduce scope' do
      a = Bol::Scope.new(1) + Bol::Scope.new(2)
      b = Bol::Scope.new(2)
      (a - b).ids.should == [1]
    end

    it 'should join ids in a string' do
      Bol::Scope.new([1,2,3]).to_s.should == '1+2+3'
    end
  end

  describe '#search' do
    it 'should default to root category from the class' do
      query = Bol::Scope.new.search 'foo'
      query.should be_instance_of Bol::Proxy
      query.category_id.should == '0'
    end

    it 'should set query term' do
      Bol::Requests::Search.should_receive(:new).with(instance_of(Bol::Query)).and_return(double(proxy: nil, query: nil))
      Bol::Scope.new.search 'foo'
    end
  end

  describe 'default category' do
    it 'should set request category scope to 0' do
      Bol::Scope.new.ids.should == [0]
    end
  end

  describe 'lists' do
    let(:cat) { Bol::Scope.new.top_products }

    it 'should create a list request' do
      cat.should be_instance_of Bol::Proxy
    end

    it 'should be scoped to the category' do
      cat.category_id.should == '0'
    end
  end

  describe 'categories' do
    let(:cat) { Bol::Scope.new.categories }

    it 'should create category list request' do
      cat.request.should be_instance_of Bol::Requests::List
    end

    it 'should use a query with a param to limit to categories' do
      cat.query.params[:includeCategories].should  == true
      cat.query.params[:includeProducts].should    == false
      cat.query.params[:includeRefinements].should == false
    end
  end

  describe 'refinements' do
    let(:cat) { Bol::Scope.new.refinements }

    it 'should create refinement list request' do
      cat.request.should be_instance_of Bol::Requests::List
    end

    it 'should use a query with a param to limit to refinements' do
      cat.query.params[:includeCategories].should  == false
      cat.query.params[:includeProducts].should    == false
      cat.query.params[:includeRefinements].should == true
    end
  end
end
