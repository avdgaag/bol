```ruby
Bol::Category.find(params[:id]).products
Bol::Category.find(params[:id]).subcategories
Bol::Category.find(params[:id]).top_products
Bol::Category.find(params[:id]).search()
Bol::Product.find(params[:id])
Bol::Product.search(params[:query]).limit(10).offset(10).order('sales_ranking ASC')
Bol::Product.search(params[:query]).page(params[:page])
```

```ruby
Bol.configure do |c|
  c.key = '...'
  c.secret = ''
  c.per_page = 10
  c.default_order = 'sales_ranking'
end
```
