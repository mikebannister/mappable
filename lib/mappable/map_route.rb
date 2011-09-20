module Mappable
  class MapRoute
    attr_reader :map, :in_value

    def initialize(map, in_value)
      @map = map
      @in_value = in_value
    end

    def mapped_value_for_method_missing(sym)
      mapping_name = sym.to_s.slice(3..-1).to_sym
      map.value_for(mapping_name, in_value)
    end

    def map_route_method?(sym)
      sym.to_s.starts_with?('to_')
    end

    def method_missing(sym, *args, &block)
      if map_route_method?(sym)
        mapped_value_for_method_missing(sym)
      else
        super(sym, *args, &block)
      end
    end
  end
end
