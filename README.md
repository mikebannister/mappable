# Mappable #

Lightweight string mappings engine for Rails

## Synopsis ##

Provides models and a UI for creating and maintaining string pairs. A tiny DSL is included so developers to easily make use of the generated data. The UI allows system administrators to create groups of string pairs that can be maintained by non-technical people.

We use this tool to map account names in a legacy system, where we don't control the names, to their corresponding names in our in-house system.

## Installation ##

Install the gem

    gem install mappable

Install the migrations

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
      t.string   "from"
      t.string   "to"
      t.string   "attr"
    end

Mount the engine

    mount Mappable::Engine => '/maps'

Definitions

 * **Mappings**: String pairs that map to each other

 * **Maps**: A group of mappings and relevant metadata

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

Better indexing in migrations
