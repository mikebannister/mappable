module Mappable
  class Engine < Rails::Engine
    isolate_namespace Mappable
    
    config.to_prepare do
      Mappable::Router.build_routes!
    end
  end
end
