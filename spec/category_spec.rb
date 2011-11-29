require 'minitest/spec'

describe Bol::Category do
  describe 'combining categories' do
    it 'should add two categories for a combined scope'
    it 'should subtract two categories to reduce scope'
    it 'should manually add category IDs'
  end

  describe '#search' do
    it 'should create new query'
    it 'should create new request'
    it 'should not send request'
    it 'should set query term'
    it 'should return query'
  end

  describe 'list methods' do
    it 'should create new request'
    it 'should return new request'
    it 'should allow setting order'
    it 'should allow setting limit'
    it 'should allow setting offset'
    it 'should allow setting page'
  end

  describe 'default category' do
    it 'should set request category scope to 0'
  end

  describe 'subcategories' do
    it 'should create category list request'
    it 'should return array of Category objects'
  end

  describe '#find' do
    it 'should create request'
    it 'should set id on request'
    it 'should request category scope when found'
    it 'should raise error when not found'
  end
end
