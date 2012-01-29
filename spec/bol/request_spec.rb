require 'spec_helper'

describe Bol::Request do
  let(:query)   { Bol::Query.new(1).limit(3) }
  let(:request) { Bol::Request.new(query) }

  it 'should require a query' do
    expect { Bol::Request.new }.to raise_error ArgumentError
  end

  it 'should convert query to params' do
    request.params.should == "categoryId=1&nrProducts=3"
  end

  describe 'signing and headers' do
    it 'should raise error when key and secret are not configured' do
      expect { request.fetch }.should raise_error Bol::ConfigurationError
    end

    it 'should request application/xml' do
      Bol.configure access_key: 'foo', secret: 'bar'
      Net::HTTP.any_instance.should_receive(:request).with do |req|
        req['Content-Type'] == 'application/xml'
      end
      request.fetch
    end

    it 'should set special date header' do
      Bol.configure access_key: 'foo', secret: 'bar'
      Net::HTTP.any_instance.should_receive(:request).with do |req|
        !req['X-OpenAPI-Date'].nil?
      end
      request.fetch
    end

    it 'should add signature to request by default' do
      Bol.configure access_key: 'foo', secret: 'bar'
      Net::HTTP.any_instance.should_receive(:request).with do |req|
        !req['X-OpenAPI-Authorization'].nil?
      end
      request.fetch
    end
  end

  it 'should trigger event manually' do
    Bol.configure access_key: 'foo', secret: 'bar'
    Net::HTTP.any_instance.should_receive(:request)
    request.fetch
  end

  describe Bol::Requests::Product do
    let(:request) { Bol::Requests::Product.new(1, query) }

    it 'should get from correct URL' do
      request.uri.to_s.should == 'https://openapi.bol.com/openapi/services/rest/catalog/v3/products/1?categoryId=1&nrProducts=3'
    end

    it 'should require product id as term' do
      expect { Bol::Requests::Product.new(query) }.to raise_error ArgumentError
    end

    it 'should URL encode the terms' do
      Bol::Requests::Product.new('foo bar', query).uri.to_s.should ==
        'https://openapi.bol.com/openapi/services/rest/catalog/v3/products/foo%20bar?categoryId=1&nrProducts=3'
    end
  end

  describe Bol::Requests::Category do
    let(:request) { Bol::Requests::Category.new(query) }

    it 'should get from correct URL' do
      request.uri.to_s.should == 'https://openapi.bol.com/openapi/services/rest/catalog/v3/categorylists/1'
    end
  end

  describe Bol::Requests::Search do
    let(:request) { Bol::Requests::Search.new('foo', query) }

    it 'should get from correct URL' do
      request.uri.to_s.should ==
        'https://openapi.bol.com/openapi/services/rest/catalog/v3/searchproducts/foo?categoryId=1&nrProducts=3'
    end

    it 'should require search terms' do
      expect { Bol::Requests::Product.new(Bol::Query.new(0)) }.to raise_error ArgumentError
    end

    it 'should encode the search terms' do
      Bol::Requests::Search.new('foo bar', query).uri.to_s.should ==
        'https://openapi.bol.com/openapi/services/rest/catalog/v3/searchproducts/foo%20bar?categoryId=1&nrProducts=3'
    end
  end

  describe Bol::Requests::List do
    let(:query)   { Bol::Query.new(0) }
    let(:request) { Bol::Requests::List.new('foo', query) }

    it 'should get from correct URL' do
      request.uri.to_s.should == 'https://openapi.bol.com/openapi/services/rest/catalog/v3/productlists/foo/0'
    end

    it 'should require param type' do
      expect { Bol::Requests::Product.new(Bol::Query.new(0)) }.to raise_error ArgumentError
    end
  end
end
