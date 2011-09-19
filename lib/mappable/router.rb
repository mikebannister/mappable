module Mappable
  class Router
    class << self
      def build_routes!
        Mappable::Map.all.each do |map|
          build_route_for_map!(:from, map)
          build_route_for_map!(:to, map)
        end
      end
      
      def build_route_for_map!(direction, map)
        mapping_name = map.send("#{direction}_mapping".to_sym)
        method_sym = "#{mapping_name}_#{map.name}_#{map.mapping_attribute}".camelize.to_sym
        Kernel.send :define_method, method_sym do |in_value|
          Mappable::Route.new(map, in_value)
        end
      end
    end
  end
end
