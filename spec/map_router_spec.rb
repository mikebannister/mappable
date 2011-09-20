require 'spec_helper'

module Mappable
  describe MapRouter do
    describe "#build_map_routes!" do
      it "build a map route for each side of each saved map" do
        Mappable::Map.create!(from_mapping: 'legacy', to_mapping: 'current', name: 'account', mapping_attribute: 'name')
        
        Mappable::MapRouter.build_map_routes!
        
        Kernel.respond_to?(:LegacyAccountName).should be_true
        Kernel.respond_to?(:CurrentAccountName).should be_true
      end
    end
    
    describe "#build_map_route!" do
      it "should build a map route for the map info supplied" do
        map = Mappable::Map.create!(from_mapping: 'legacy', to_mapping: 'current', name: 'account', mapping_attribute: 'name')

        Mappable::MapRouter.build_map_route!(:from, map)
        Mappable::MapRouter.build_map_route!(:to, map)

        Kernel.respond_to?(:LegacyAccountName).should be_true
        Kernel.respond_to?(:CurrentAccountName).should be_true
      end
    end
  end
end
