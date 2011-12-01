**Currently a work in progress**

A Ruby wrapper around the [bol.com developers API][docs], that will be made
available as a Gem. Currently in pre-alpha stage.

[docs]: http://developers.bol.com

## Available operations

Here's an overview of all the operations that should be implemented:

```ruby
Bol::Category.find(params[:id]).products
Bol::Category.find(params[:id]).subcategories
Bol::Category.find(params[:id]).top_products
Bol::Category.find(params[:id]).search(params[:query])
Bol::Product.find(params[:id])
Bol::Product.search(params[:query]).limit(10).offset(10).order('sales_ranking ASC')
Bol::Product.search(params[:query]).page(params[:page])
```

These simply map to operations provided by the API to search, load lists of
products or load a single product by ID. I do aim to a add a little sugar
to make working with Ruby objects a little easier:

* Add `page` helper method to combine `limit` and `offset`
* Scope operations by category in a ActiveRecord association style
* Delay API calls until explicitly requested or triggered by looping over
  results

## Configuration

```ruby
Bol.configure do |c|
  c.key = 'your public access key'
  c.secret = 'your private secret'
  c.per_page = 10
  c.default_order = 'sales_ranking'
end
```

## Note on Patches/Pull Requests

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a future version
  unintentionally.
* Commit, do not mess with rakefile, version, or history. (if you want to have
  your own version, that is fine but bump version in a commit by itself I can
  ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## History

For a full list of changes, please see CHANGELOG.md

## License

Copyright (C) 2011 by Arjan van der Gaag. Published under the MIT license. See
LICENSE.md for details.
