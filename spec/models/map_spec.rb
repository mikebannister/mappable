require 'spec_helper'

module Mappable
  describe Map do
    before do
      @map = Mappable::Map.create!(subject: 'account', attr: 'name', from: 'legacy', to: 'current')
    end

    describe "#value_for" do
      it "should return the value for value given" do
        Mappable::Mapping.create!(map: @map, from: 'moof', to: 'doof')
        
        @map.value_for(:current, 'moof').should eq 'doof'
        @map.value_for(:legacy, 'doof').should eq 'moof'
      end

      it "should return nil if there's no mapping available" do
        Mappable::Mapping.create!(map: @map, from: 'moof', to: 'doof')
        
        @map.value_for(:current, 'XXX').should eq nil
      end

      it "should return nil if there's 0 mappings in the system" do
        @map.value_for(:current, 'XXX').should eq nil
      end
    end

    describe "#after_save" do
      it "should load the new map routes" do
        Mappable::Mapping.create!(map: @map, from: 'moof', to: 'doof')
        map = Mappable::Map.new(subject: 'noof', attr: 'aloof', from: 'moof', to: 'doof')
        map.save!
        Kernel.respond_to?(:MoofNoofAloof).should be_true
        Kernel.respond_to?(:DoofNoofAloof).should be_true
      end
    end

    describe "#cached_mappings" do
      it "should preload all child mappings in both directions" do
        Mappable::Mapping.create!(map: @map, from: 'foo', to: 'bar')
        Mappable::Mapping.create!(map: @map, from: 'moof', to: 'toof')

        expected_mapping = {
          from: {
            'foo' => 'bar',
            'moof' => 'toof'
          },
          to: {
            'bar' => 'foo',
            'toof' => 'moof'
          }
        }

        @map.cached_mappings.should eq expected_mapping
      end

      it "should use lowercase keys and preserve case of the value" do
        Mappable::Mapping.create!(map: @map, from: 'AAA', to: 'bbb')
        Mappable::Mapping.create!(map: @map, from: 'ccc', to: 'DDD')

        expected_mapping = {
          from: {
            'aaa' => 'bbb',
            'ccc' => 'DDD'
          },
          to: {
            'bbb' => 'AAA',
            'ddd' => 'ccc'
          }
        }

        @map.cached_mappings.should eq expected_mapping
      end
    end
  end
end
