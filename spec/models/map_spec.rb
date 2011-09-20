require 'spec_helper'

module Mappable
  describe Map do
    before do
      @map = Mappable::Map.create!(subject: 'account', attr: 'name', from: 'legacy', to: 'current')
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
        map = Mappable::Map.new(subject: 'noof', attr: 'aloof', from: 'moof', to: 'doof')
        map.save!
        Kernel.respond_to?(:MoofNoofAloof).should be_true
        Kernel.respond_to?(:DoofNoofAloof).should be_true
      end
    end
  end
end
