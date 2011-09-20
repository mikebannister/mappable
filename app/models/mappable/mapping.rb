module Mappable
  class Mapping < ActiveRecord::Base
    belongs_to :map
    belongs_to :parent_map, :foreign_key => :map_id, :class_name => :Map
  end
end
