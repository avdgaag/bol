require 'spec_helper'

describe Bol do
  describe '#configure' do
    it 'should create configuration object' do
      Bol.configure access_key: 'foo'
      Bol.configuration.access_key.should == 'foo'
    end

    it 'should reset configuration' do
      Bol.configure access_key: 'foo'
      expect {
        Bol.reset_configuration
      }.to change {
        Bol.configuration.access_key
      }.to nil
    end

    it 'should yield config object without argument' do
      Bol.configure do |c|
        c.should == Bol.configuration
      end
    end

    it 'should raise with non-hash argument' do
      expect { Bol.configure 'foo' }.to raise_error ArgumentError
    end

    it 'should not yield with argument' do
      Bol.configure(access_key: 'foo') { |c| flunk }
    end
  end

  describe 'shortcut methods' do
    it 'should delegate search to a new scope object' do
      Bol::Scope.any_instance.should_receive(:search).with('foo')
      Bol.search('foo')
    end

    it 'should delegate categories to a new scope object' do
      Bol::Scope.any_instance.should_receive(:categories)
      Bol.categories
    end

    it 'should delegate find to a new scope object' do
      Bol::Scope.any_instance.should_receive(:search).with(1)
      Bol.search(1)
    end

    it 'should delegate refinements to a new scope object' do
      Bol::Scope.any_instance.should_receive(:refinements)
      Bol.refinements
    end
  end
end
