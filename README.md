# Mappable #

Lightweight string mappings engine for Rails

## Synopsis ##

Provides models and a UI for creating and maintaining string pairs. A tiny DSL is included so developers to easily make use of the generated data. The UI allows system administrators to create groups of string pairs that can be maintained by non-technical people.

We use this tool to map account names in a legacy system, where we don't control the names, to their corresponding names in our in-house system.

## Installation ##

Add it to your `Gemfile`

    gem 'mappable'

Bundle it up

    bundle install

Install the migrations and apply them

    rake mappable:install:migrations
    rake db:migrate

The migrations will add tables similar to this

    create_table "mappable_mappings", :force => true do |t|
      t.integer  "map_id"
      t.string   "from"
      t.string   "to"
    end

    create_table "mappable_maps", :force => true do |t|
      t.string   "subject"
      t.string   "attr"
      t.string   "from"
      t.string   "to"
    end

Mount the engine

    mount Mappable::Engine => '/map'

You can use the included generator to copy the views if you'd like to customize them

    rails generate mappable:views

If you want to override the views for `mappings` that belong to a specific `map` puts them in `app/views/mappable/[MAP_NAME]/mappings`. You can also generate these scoped views:

    rails generate mappable:views account_names

Definitions

 * **Mappings**: String pairs that map to each other

    - [http://localhost:3000/map/account/name](http://localhost:3000/map/account/name)

 * **Maps**: A group of mappings and relevant metadata.

    - [http://localhost:3000/map](http://localhost:3000/maps)

## Example usage ##

Given the following records

### Map ###

    id = 1
    subject = 'account'
    attr = 'name'
    from = 'legacy'
    to = 'current'

### Mapping ###

    id = 1
    map_id = 1
    from = 'Old Account Name'
    to = 'New Account Name'

Now you can map strings in either direction using the following grammar

    LegacyAccountName("Old Account Name").to_current #=> "New Account Name"
    CurrentAccountName("New Account Name").to_legacy #=> "Old Account Name"

## TODO ##

Move rebuilding of maps to an initializer and/or add notes to readme about why Map.all gets called on every request in development
Better indexing in migrations
Add security features
Deal with going from/to when there's more than one to with the same name
