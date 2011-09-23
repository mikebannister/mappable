require 'spec_helper'

module Mappable
  describe Mapping do
    let(:map) { Mappable::Map.new(subject: 'account', attr: 'name', from: 'legacy', to: 'current') }
    let(:mapping) { Mappable::Mapping.new(map: map, from: 'moof', to: 'doof') }

    it "should be valid if all fields are valid" do
      mapping.should be_valid
    end

    it "should be invalid if map_id combined with from field are not unique" do
      mapping.save!
      duplicate_mapping = Mappable::Mapping.new(map: map, from: 'moof', to: 'anything')

      duplicate_mapping.should_not be_valid
    end

    it "should be invalid without a map" do
      mapping.save!
      another_mapping = mapping.clone
      another_mapping.map = nil
      
      mapping.should_not be_valid
    end
  end
end
