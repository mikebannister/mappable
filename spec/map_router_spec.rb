require 'spec_helper'

module Mappable
  describe MapRouter do
    before do
      clear_kernel_method :LegacyAccountName
      clear_kernel_method :CurrentAccountName
    end
    
    describe "#build_map_routes!" do
      it "should build a map route for each side of each saved map" do
        Mappable::Map.create!(subject: 'account', attr: 'name', from: 'legacy', to: 'current')
        
        Mappable::MapRouter.build_map_routes!
        
        Kernel.respond_to?(:LegacyAccountName).should be_true
        Kernel.respond_to?(:CurrentAccountName).should be_true
      end

      it "should not build route maps if the tables don't exist yet, duh!" do
        Mappable::Map.stubs(:table_exists?).returns(false)
        Mappable::Map.create!(subject: 'account', attr: 'name', from: 'legacy', to: 'current')
        
        Mappable::MapRouter.build_map_routes!
        
        Kernel.respond_to?(:LegacyAccountName).should be_false
        Kernel.respond_to?(:CurrentAccountName).should be_false
      end
    end
    
    describe "#build_map_route!" do
      it "should build a map route for the map info supplied" do
        map = Mappable::Map.create!(subject: 'account', attr: 'name', from: 'legacy', to: 'current')

        Mappable::MapRouter.build_map_route!(:from, map)
        Mappable::MapRouter.build_map_route!(:to, map)

        Kernel.respond_to?(:LegacyAccountName).should be_true
        Kernel.respond_to?(:CurrentAccountName).should be_true
      end
    end
  end
end
