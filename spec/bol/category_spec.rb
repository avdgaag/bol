require 'spec_helper'

describe Bol::Category do
  describe '#categories' do
    let(:r) { Bol.categories.all }

    before do
      Bol.configure access_key: 'foo', secret: 'bar'
      FakeWeb.register_uri(:get, 'https://openapi.bol.com/openapi/services/rest/catalog/v3/listresults/toplist_default/0?categoryId=0&includeCategories=true&includeProducts=false&includeRefinements=false',
                           body: fixture('categorylist.xml')) 
    end 
    it 'should return an array of categories' do
      r.should be_instance_of Array
    end
    it 'should have 9 categories' do 
      r.size.should == 9
    end
    it 'should have boeken as the first category' do
      boeken = r.first
      boeken.id.to_i.should == 8299
      boeken.name.should == "Boeken"
      boeken.count.should == 5129135
    end
  end
end
