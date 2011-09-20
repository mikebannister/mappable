require 'spec_helper'

module Mappable
  describe MapRoute do
    before do
      map = Mappable::Map.create!(from: 'legacy', to: 'current', name: 'account', attr: 'name')
      Mappable::Mapping.create!(map: map, from: 'moof', to: 'doof')
    end

    describe "#mapped_value_for_method_missing" do
      it "should map value from the map route in the direction inferred by the incoming method name which is normally passed in by method_missing" do
        map_route = LegacyAccountName('moof')
        map_route.mapped_value_for_method_missing(:to_current).should eq 'doof'

        map_route = CurrentAccountName('doof')
        map_route.mapped_value_for_method_missing(:to_legacy).should eq 'moof'
      end
    end

    describe "#map_route_method?" do
      it "it should return true if the method starts with to_" do
        LegacyAccountName('moof').map_route_method?(:to_anything).should be_true
      end

      it "it should return false if the method doesn't start with to_" do
        LegacyAccountName('moof').map_route_method?(:anything_else).should be_false
      end
    end
    
    describe "#method_missing" do
      describe "#to_current" do
        it "get's the current value for the supplied legacy value" do
          LegacyAccountName('moof').to_current.should eq 'doof'
        end
      end
    
      describe "#to_legacy" do
        it "get's the legacy value for the supplied current value" do
          CurrentAccountName('doof').to_legacy eq 'doof'
        end
      end
    end
  end
end
