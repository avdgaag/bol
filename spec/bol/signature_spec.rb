require 'spec_helper'

describe Bol::Signature do
  let(:subject) { described_class.new('date', 'path', {}) }

  def configure
    Bol.configuration.access_key = 'foo'
    Bol.configuration.secret = 'bar'
  end

  before { configure }

  it 'should return a string' do
    subject.generate.should be_instance_of(String)
  end

  it 'should validate configuration' do
    Bol.reset_configuration
    expect {
      described_class.new(1, 2, {})
    }.to raise_error(Bol::ConfigurationError)
    configure
    expect {
      described_class.new(1, 2, {})
    }.not_to raise_error
  end
end
