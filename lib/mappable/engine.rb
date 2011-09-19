module Mappable
  class Engine < Rails::Engine
    isolate_namespace Mappable
    
    config.to_prepare do
      Mappable::Engine.build_map_routes!
    end
    
    class << self
      def build_map_routes!
        begin
          Mappable::Router.build_routes!
        rescue Exception => e
          # added so rake db:migrate can silently fail
          raise e unless e.message =~ /Could not find table/
        end
      end
    end
  end
end
