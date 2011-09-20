module Mappable
  class Map < ActiveRecord::Base
    has_many :mappings

    after_save do
      Mappable::MapRouter.build_map_routes!
    end

    def value_for(mapping_name, in_value)
      in_value_direction = :from if to_mapping.to_sym == mapping_name
      in_value_direction = :to if from_mapping.to_sym == mapping_name
      if in_value_direction
        out_value_direction = :from if in_value_direction == :to
        out_value_direction = :to if in_value_direction == :from
        self.mappings.where(in_value_direction => in_value).first.send(out_value_direction)
      end
    end
  end
end
