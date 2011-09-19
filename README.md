# Mappable #

Lightweight string mappings engine for Rails

## Synopsis ##

TODO

Install the gem

    gem install mappable

Install the migrations

    rake mappable:install:migrations
    rake db:migrate

This adds schema similar to

    create_table "mappable_mappings", :force => true do |t|
      t.integer  "map_id"
      t.string   "from"
      t.string   "to"
    end

    create_table "mappable_maps", :force => true do |t|
      t.string   "name"
      t.string   "from_mapping"
      t.string   "to_mapping"
      t.string   "mapping_attribute"
    end

Mount the engine

    mount Mappable::Engine => '/maps'

You can use the UI available at the engine's mount point to add new maps and mappings.

Add some records

    Map
    ----------------
    id = 1
    name = account
    from_mapping = legacy
    to_mapping = system
    mapping_attribute = name

    Mapping
    ----------------
    id = 1
    map_id = 1
    from = moof
    to = doof

You can map strings in either direction:

    LegacyAccountName("moof account").to_system # => "doof account"
    SystemAccountName("doof account").to_legacy # => "moof account"

## TODO ##

Better indexing in migrations
