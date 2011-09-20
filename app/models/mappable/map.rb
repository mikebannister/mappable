module Mappable
  class Map < ActiveRecord::Base
    has_many :mappings

    after_save do
      Mappable::MapRouter.build_map_routes!
    end

    def value_for(mapping_name, in_value)
      in_direction = :from if to.to_sym == mapping_name
      in_direction = :to if from.to_sym == mapping_name
      if in_direction
        out_direction = :from if in_direction == :to
        out_direction = :to if in_direction == :from
        self.mappings.where(in_direction => in_value).first.send(out_direction)
      end
    end
  end
end
