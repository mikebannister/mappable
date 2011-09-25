require 'spec_helper'

module Mappable
  describe MappingsController do
    let(:map) { Mappable::Map.create!(subject: 'account', attr: 'name', from: 'legacy', to: 'current') }

    describe "GET index" do
      it "should look up the map specified in params and assign it to @map" do
        map # load
        
        get :index, subject: 'account', attr: 'name', :use_route => :mappable
        assigns(:map).should eq map
      end

      it "should error out if the attributes specify a non-existent map" do
        lambda {
          get :index, subject: 'account', attr: 'name', :use_route => :mappable
        }.should raise_error ActiveRecord::RecordNotFound
      end
      
      it "should lookup and assign the specified map's mappings to @mappings" do
        map # load
        mapping = map.mappings.create!(from: 'moof1', to: 'doof1')
        mapping = map.mappings.create!(from: 'moof2', to: 'doof2')
        mapping = map.mappings.create!(from: 'moof3', to: 'doof3')

        another_map = Mappable::Map.create!(subject: 'employee', attr: 'name', from: 'legacy', to: 'current')
        mapping = another_map.mappings.create!(from: 'moof1', to: 'doof1')
        
        get :index, subject: 'account', attr: 'name', :use_route => :mappable
        assigns(:mappings).should have_exactly(3).items
      end
    end

    describe "POST create" do
      describe "with valid params" do
        it "redirects to the mappings list" do
          post :create, mapping: { map_id: map.id }, :use_route => :mappable
          response.should redirect_to('/map/account/names')
        end
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        it "redirects to the mappings list" do
          map # load
          mapping = map.mappings.create!(from: 'moof', to: 'doof')

          put :update, id: mapping.id, :use_route => :mappable
          response.should redirect_to('/map/account/names')
        end
      end
    end

    describe "GET new" do
      let(:mapping) { Mappable::Mapping.create!(map: map, from: 'Old account name', to: 'New account name') }

      it "should look up the map specified in params and assign it to @map" do
        map # load
        mapping # load

        get :new, subject: 'account', attr: 'name', :use_route => :mappable
        assigns(:map).should eq map
      end

      it "should look up the map specified and set it to the map attribute of the new mapping" do
        map # load
        mapping # load

        get :new, subject: 'account', attr: 'name', :use_route => :mappable
        assigns(:mapping).map.should eq map
      end

      it "should error out if the attributes specify a non-existent map" do
        mapping # load

        lambda {
          get :new, subject: 'no_account', attr: 'no_name', :use_route => :mappable
        }.should raise_error ActiveRecord::RecordNotFound
      end
    end
  end
end
