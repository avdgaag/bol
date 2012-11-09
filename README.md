# Bol

[![Build Status](https://secure.travis-ci.org/avdgaag/bol.png?branch=master)](http://travis-ci.org/avdgaag/bol)

A Ruby wrapper around the [bol.com developers API][docs], that will be made
available as a Gem. *Currently in beta stage.*

[docs]: http://developers.bol.com

## Getting started

### Installation

Bol is a simple Ruby gem, so it requires a working installation of Ruby with
Ruby gems. Note: **Ruby 1.9 is required**. Install the gem:

```
$ gem install bol
```

Or, if your project uses [Bundler][] simply add it to your `Gemfile`:

[Bundler]: http://gembundler.com

```ruby
gem 'bol'
```

Then, simply `require` it in your code, provide some configuration settings and
query away.

### Configuration

To be allowed to make requests to the Bol.com API you need to register on their
site and request a access key and secret. Configure the Bol gem as follows:

```ruby
Bol.configure do |c|
  c.access_key = 'your public access key'
  c.secret = 'your private secret'
  c.per_page = 10
end
```

### Example application

See an example Sinatra application implementing basic search-and-display 
functionality: [https://gist.github.com/1724664](https://gist.github.com/1724664).
There's [an introductory blog post](http://arjanvandergaag.nl/blog/bol-gem.html)
to go with it.

## Available operations

Here are the currently working operations:

### Loading a specific product

If you know an ID, you can load a product directly:

```ruby
product = Bol::Product.find(params[:id])
product.title
product.cover(:medium)
product.referral_url('my_associate_id')
```

### Listing products

You can get a list of popular or bestselling products:

* `Bol.top_products`
* `Bol.top_products_overall`
* `Bol.top_products_last_week`
* `Bol.top_products_last_two_months`
* `Bol.new_products`
* `Bol.preorder_products`

Or, you can apply a scope to limit results to a category:

```ruby
Bol::Scope.new(params[:category_id]).top_producs
```

### Searching products

You can search globally for keywords or ISBN and use a Arel-like syntax
for setting options:

```ruby
Bol.search(params[:query]).limit(10).offset(10).order('sales_ranking ASC')
Bol.search(params[:query]).page(params[:page])
```

You can scope your search to a specific category:

```ruby
Bol::Scope.new(params[:category_id]).search(params[:query])
```

### Loading categories and refinements

Loading all top-level categories (e.g. `DVDs` or `English Book`) is simple
enough:

```ruby
categories = Bol.categories
categories.first.name # => 'Books'
```

You can load subsequent subcategories:

```ruby
Bol::Scope.new(categories.first.id).categories
```

Refinements (e.g. 'under 10 euros') work much the same way as categories, but
are grouped under a shared name, such as group 'Price' with refinements 'up to
10 euros', '10 to 20 euros', etc.:

```ruby
groups = Bol.refinements
group = groups.first
group.name # => 'Price'
group.refinements.first.name # => 'under 10 euros'
```

### Scoping operations

The `Bol::Scope` object limits results to given categories and/or refinements.
You can create a scope using explicit IDs, and you can do basic combinations:

```ruby
books = Bol::Scope.new(some_category_id)
cheap = Bol::Scope.new(some_refinement_id)
(books + cheap).top_products
```

Here's an overview of all the operations that should still be implemented:

## Background

The available operations map almost directly to operations provided by the API
to search, load lists of products or load a single product by ID. I do aim to
a add a little sugar to make working with Ruby objects a little easier:

* Add `page` helper method to combine `limit` and `offset`
* Scope operations by category in a ActiveRecord association style
* Delay API calls until explicitly requested or triggered by looping over
  results

## Wishlist

* Allow scoping by category or refinement objects instead of just IDs
* Add a simple identiy map, so the same product does not have to be loaded
  twice when requested twice
* Properly differentiate between product types. Currently built around books;
  DVDs, music and toys may or may not work as expected.
* Add default ordering of products

I do not need this stuff myself, but I will gladly take pull requests for such
features.

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
