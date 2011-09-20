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
      t.string   "subject"
      t.string   "from"
      t.string   "to"
      t.string   "attr"
    end

Mount the engine

    mount Mappable::Engine => '/maps'

You can use the UI available at the engine's mount point to add new maps and mappings.

### Records ###

#### Map ####

    id = 1
    subject = 'account'
    attr = 'name'
    from = 'legacy'
    to = 'current'

#### Mapping ####

    id = 1
    map_id = 1
    from = 'Old Account Name'
    to = 'New Account Name'

No you can map strings in either direction:

    LegacyAccountName("Old Account Name").to_current #=> "New Account Name"
    CurrentAccountName("New Account Name").to_legacy #=> "Old Account Name"

## TODO ##

Better indexing in migrations
