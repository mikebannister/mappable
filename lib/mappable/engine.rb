module Mappable
  class Engine < Rails::Engine
    isolate_namespace Mappable
    
    config.to_prepare do
      Mappable::MapRouter.build_map_routes!
    end
  end
end
