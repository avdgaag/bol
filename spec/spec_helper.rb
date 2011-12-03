require 'minitest/spec'
require 'minitest/autorun'
require 'mocha'
require 'fakeweb'
require 'bol'

FakeWeb.allow_net_connect = false

def fixture(name)
  File.read(File.expand_path(File.join("../fixtures/#{name}"), __FILE__))
end

