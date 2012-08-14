require 'spec_helper'

describe Bol::Parsers::Refinements do
  let(:request) do
    double('request').tap do |r|
      r.stub(:fetch).and_return(r)
      r.stub(:body).and_return(body)
    end
  end
  let(:refinement) { Bol::Parsers::Refinements.new(request).objects.first }

  describe 'parsing refinement groups' do
    let(:body) { fixture('refinements.xml') }

    it 'should set simple attributes' do
      refinement.id.should == '1'
      refinement.name.should == 'categorieen'
    end

    it 'should find nested elements' do
      refinement.refinements.size.should == 9
    end

    it 'should parse nested elements' do
      boeken = refinement.refinements.first
      boeken.name.should == 'Boeken'
      boeken.id.should == '8299'
      boeken.count.should == '5173467'
      computer = refinement.refinements.last
      computer.name.should == 'Computer'
      computer.id.should == '3134'
      computer.count.should == '8314'
    end
  end
end
