require 'rspec'
require 'fakeweb'
require 'bol'
require 'support'

RSpec.configure do |config|
  config.before(:suite) do
    FakeWeb.allow_net_connect = false
  end

  config.after(:each) do
    Bol.reset_configuration
  end

  config.include SpecHelpers
end
