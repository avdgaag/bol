require 'spec_helper'

describe Bol::Proxy do
  let(:parser)  { double('parser') }
  let(:query)   { double('query', category_id: 1) }
  let(:request) { double('request', query: query) }
  let(:subject) { described_class.new(request, parser) }

  it 'should delegate methods to query' do
    subject.category_id.should == 1
  end

  it 'should delegate query' do
    subject.query.should == query
  end

  it 'should delegate query methods' do
    query.should_receive(:offset).with(5)
    query.should_receive(:limit).with(10)
    subject.offset(5)
    subject.limit(10)
  end

  it 'should get objects from parser' do
    parser.should_receive(:objects).and_return([])
    subject.all
    subject.all
  end

  it 'should get objects from parser when looping' do
    parser.should_receive(:objects).and_return([])
    subject.each {}
  end
end
