require 'spec_helper'

module Mappable
  describe Router do
    describe "#build_routes!" do
      it "build a route for each side of each saved map" do
        Mappable::Map.create!(from_mapping: 'legacy', to_mapping: 'current', name: 'account', mapping_attribute: 'name')
        
        Mappable::Router.build_routes!
        
        Kernel.respond_to?(:LegacyAccountName).should be_true
        Kernel.respond_to?(:CurrentAccountName).should be_true
      end
    end
    
    describe "#build_route_for_map!" do
      it "should build a route for the route info supplied" do
        map = Mappable::Map.create!(from_mapping: 'legacy', to_mapping: 'current', name: 'account', mapping_attribute: 'name')

        Mappable::Router.build_route_for_map!(:from, map)
        Mappable::Router.build_route_for_map!(:to, map)

        Kernel.respond_to?(:LegacyAccountName).should be_true
        Kernel.respond_to?(:CurrentAccountName).should be_true
      end
    end
  end
end
