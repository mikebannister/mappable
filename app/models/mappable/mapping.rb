module Mappable
  class Mapping < ActiveRecord::Base
    belongs_to :map
    belongs_to :parent_map, :foreign_key => :map_id, :class_name => :Map
    
    validates_uniqueness_of :from, :scope => :map_id, :message => "must be unique [%{value}]"
    validates_presence_of :map
  end
end
