module Mappable
  class Map < ActiveRecord::Base
    has_many :mappings

    after_save do
      Mappable::MapRouter.build_map_routes!
    end

    def cached_mappings
      @cache ||= begin
        self.mappings.inject({}) do |cache, m|
          cache[:to] ||= {}
          cache[:to][m.to.downcase] = m.from

          cache[:from] ||= {}
          cache[:from][m.from.downcase] = m.to
          
          cache
        end
      end
    end

    def value_for(mapping_name, in_value)
      direction = :from if to.to_sym == mapping_name
      direction = :to if from.to_sym == mapping_name
      if direction
        cached_mappings[direction][in_value.downcase]
      end
    end
  end
end
