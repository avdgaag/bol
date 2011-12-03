**Currently a work in progress**

A Ruby wrapper around the [bol.com developers API][docs], that will be made
available as a Gem. Currently in alpha stage.

[docs]: http://developers.bol.com

## Available operations

Here are the currently working operations:

```ruby
Bol::Product.find(params[:id])
Bol.search(params[:query]).limit(10).offset(10).order('sales_ranking ASC')
Bol.search(params[:query]).page(params[:page])
Bol::Category.new(params[:id]).search(params[:query])
Bol::Category.new(params[:id]).top_products
Bol::Category.new(params[:id]).top_products_overall
Bol::Category.new(params[:id]).top_products_last_week
Bol::Category.new(params[:id]).top_products_last_two_months
Bol::Category.new(params[:id]).new_products
Bol::Category.new(params[:id]).preorder_products
```

Here's an overview of all the operations that should still be implemented:

```ruby
Bol::Category.new(params[:id]).subcategories
(Bol::Category.new(1) + Bol::Category.new(2)).top_products
```

## Background

The available operations map almost directly to operations provided by the API
to search, load lists of products or load a single product by ID. I do aim to
a add a little sugar to make working with Ruby objects a little easier:

* Add `page` helper method to combine `limit` and `offset`
* Scope operations by category in a ActiveRecord association style
* Delay API calls until explicitly requested or triggered by looping over
  results

## Wishlist

* Add a simple identiy map, so the same product does not have to be loaded
  twice when requested twice
* Properly differentiate between product types. Currently built around books;
  DVDs, music and toys may or may not work as expected.
* Properly support categories, multiple categories, and category refinements
  (like "under 5 euro").
* Add default ordering of products

I do not need this stuff myself, but I will gladly take pull requests for such
features.

## Configuration

```ruby
Bol.configure do |c|
  c.key = 'your public access key'
  c.secret = 'your private secret'
  c.per_page = 10
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
