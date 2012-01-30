require 'spec_helper'

describe Bol::Query do
  let(:subject) { Bol::Query.new(0) }

  describe 'category scope' do
    it 'should set category scope' do
      Bol::Query.new(1).category_id.should == 1
    end

    it 'should raise unless given a number' do
      expect { Bol::Query.new('foo') }.to raise_error ArgumentError
    end

    it 'should set category param' do
      Bol::Query.new(1).params[:categoryId].should == 1
    end

    it 'should accept multiple category IDs' do
      expect { Bol::Query.new('1+2+3') }.to_not raise_error
    end
  end

  describe '#has_param?' do
    it { should have_param(:categoryId) }
    it { should_not have_param(:term) }
    it { should_not have_param(:foo) }
  end

  describe '#limit' do
    context 'when set' do
      let(:subject) { Bol::Query.new(0).limit('10') }
      its(:limit) { should == 10 }
      it { should have_param(:nrProducts) }
    end

    context "when not set" do
      it { should_not have_param(:nrProducts) }
    end
  end

  describe '#page' do
    context 'page 2' do
      let(:subject) { Bol::Query.new(0).page(2) }
      it { should have_param(:nrProducts) }
      it { should have_param(:offset) }
      its(:limit) { should == 10 }
      its(:offset) { should == 10 }
    end

    context 'defaults' do
      let(:subject) { Bol::Query.new(0).page(nil) }
      it { should have_param(:nrProducts) }
      it { should have_param(:offset) }
      its(:limit) { should == 10 }
      its(:offset) { should == 0 }
    end

    context '20 per page' do
      before { Bol.configuration[:per_page] = 20 }
      after { Bol.configuration[:per_page] = 10 }
      let(:subject) { Bol::Query.new(0).page(3) }
      it { should have_param(:nrProducts) }
      it { should have_param(:offset) }
      its(:limit) { should == 20 }
      its(:offset) { should == 40 }
    end
  end

  describe '#offset' do
    context 'when set' do
      let(:subject) { Bol::Query.new(0).offset('10') }
      its(:offset) { should == 10 }
      it { should have_param(:offset) }
    end

    context 'when not set' do
      it { should_not have_param(:offset) }
    end
  end

  describe '#search' do
    context 'when set' do
      let(:subject) { Bol::Query.new(0).search('foo') }
      it { should have_param(:term) }
      its(:search) { should == 'foo' }
    end

    context 'when not set' do
      it { should_not have_param(:term) }
    end
  end

  describe '#order' do
    it 'should raise unless wrong format' do
      expect { subject.order('foo') }.to raise_error ArgumentError
    end

    it 'should add order direction on request' do
      subject.order('price ASC').params[:sortingAscending].should == 'true'
      subject.order('price DESC').params[:sortingAscending].should == 'false'
    end

    it 'should add order key on request' do
      subject.order('price ASC').params[:sortingMethod].should == 'price'
    end

    it 'should return query' do
      subject.order('price ASC').should == subject
    end
  end

  describe "query methods" do
    it 'should include categories' do
      subject.include :categories
      subject.should be_categories
    end

    it 'should include categories' do
      subject.include :categories
      subject.should be_categories
    end

    it 'should include categories' do
      subject.include :categories
      subject.should be_categories
    end
  end
end
