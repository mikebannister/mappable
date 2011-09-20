module Mappable
  class MapRouter
    class << self
      def build_map_routes!
        # this can get called before the database has been migrated
        return unless Mappable::Map.table_exists?
        Mappable::Map.all.each do |map|
          build_map_route!(:from, map)
          build_map_route!(:to, map)
        end
      end
      
      def build_map_route!(direction, map)
        mapping_name = map.send(direction.to_sym)
        method_sym = "#{mapping_name}_#{map.subject}_#{map.attr}".camelize.to_sym
        Kernel.send :define_method, method_sym do |in_value|
          Mappable::MapRoute.new(map, in_value)
        end
      end
    end
  end
end
