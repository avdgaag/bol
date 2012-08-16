require 'spec_helper'

describe Bol::Parsers::Products do
  let(:request) do
    double('request').tap do |r|
      r.stub(:fetch).and_return(r)
      r.stub(:body).and_return(body)
    end
  end
  let(:product) { Bol::Parsers::Products.new(request).objects.first }

  describe 'parsing products' do
    let(:body) { fixture('products.xml') }

    it 'should set simple attributes' do
      product.id.should == '1001004006016448'
      product.title.should == 'Harry Potter Boxed Set (Adult Edition)'
      product.subtitle.should == 'Volume 1 - 7, paperback'
      product.publisher.should == 'Bloomsbury Publishing PLC'
      product.ean.should == '9780747595847'
      product.attributes[:binding_description].should == 'Paperback'
      product.language_code.should == 'en'
      product.language_description.should == 'Engels'
      product.url.should == 'http://www.bol.com/nl/p/engelse-boeken/harry-potter-boxed-set/1001004006016448/index.html'
      product.rating.should == '5'
      product.authors.should include 'J. K. Rowling'
      product.authors.should include 'J.K. Rowling'
    end

    it 'should parse release date' do
      product.release_date.year.should == 2008
      product.release_date.month.should == 10
      product.release_date.day.should == 1
    end

    it 'should parse offers' do
      product.offers.first.state.should == 'new'
      product.offers.first.price.should == '70.99'
      product.offers.first.list_price.should == '78.99'
      product.offers.first.availability_code.should == '167'
      product.offers.first.availability_description.should == '5-10 werkdagen'
    end

    it 'should parse cover' do
      product.cover.should == 'http://s-bol.com/imgbase0/imagebase/thumb/FC/8/4/4/6/1001004006016448.jpg'
      product.cover(:medium).should == 'http://s-bol.com/imgbase0/imagebase/thumb/FC/8/4/4/6/1001004006016448.jpg'
      product.cover(:extra_small).should == 'http://s-bol.com/imgbase0/imagebase/mini/FC/8/4/4/6/1001004006016448.jpg'
      product.cover(:small).should == 'http://s-bol.com/imgbase0/imagebase/tout/FC/8/4/4/6/1001004006016448.jpg'
      product.cover(:large).should == 'http://s-bol.com/imgbase0/imagebase/regular/FC/8/4/4/6/1001004006016448.jpg'
      product.cover(:extra_large).should == 'http://s-bol.com/imgbase0/imagebase/large/FC/8/4/4/6/1001004006016448.jpg'
    end
  end

  describe 'parsing product search results' do
    let(:body) { fixture('searchproducts-music.xml') }
    let(:products) { Bol::Parsers::Products.new(request).objects }

    it 'should parse into array of products' do
      products.size.should == 2
      products[0].should be_instance_of Bol::Product
      products[1].should be_instance_of Bol::Product
    end

    it 'should have parsed xml into products' do
      products[0].title.should == 'Glass: Violin Concerto, Company etc / Adele Anthony, Takuo Yuasa et al'
      products[1].title.should == 'Adele'
    end
  end

  describe 'parsing product listings' do
    let(:body) { fixture('productlists.xml') }
    let(:products) { Bol::Parsers::Products.new(request).objects }

    it 'should parse into array of products' do
      products.size.should == 2
      products[0].should be_instance_of Bol::Product
      products[1].should be_instance_of Bol::Product
    end

    it 'should have parsed xml into products' do
      products[0].title.should == 'In mijn dromen'
      products[1].title.should == 'Kort'
    end
  end
end
