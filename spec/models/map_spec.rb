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
      it "should load the new map routes" do
        map = Mappable::Map.new(from_mapping: 'moof', to_mapping: 'doof', name: 'noof', mapping_attribute: 'aloof')
        map.save!
        Kernel.respond_to?(:MoofNoofAloof).should be_true
        Kernel.respond_to?(:DoofNoofAloof).should be_true
      end
    end
  end
end
