require 'spec_helper'

module Mappable
  describe Map do
    before do
      @map = Mappable::Map.create!(from_mapping: 'legacy', to_mapping: 'current', name: 'account', mapping_attribute: 'name')
      Mappable::Mapping.create!(map: @map, from: 'moof', to: 'doof')
    end

    describe "#value_for" do
      it "should return the value for " do
        @map.value_for(:current, 'moof').should eq 'doof'
        @map.value_for(:legacy, 'doof').should eq 'moof'
      end
    end
    
    describe "#after_save" do
      it "should called Mappable::Router.build_routes!" do
        Mappable::Router.expects(:build_routes!).times(2)
        @map.save!
        Mappable::Router.build_routes!
      end
    end
  end
end
