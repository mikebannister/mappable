require 'spec_helper'

module Mappable
  describe MapsController do
    describe "POST create" do
      describe "with valid params" do
        it "redirects to the maps list" do
          post :create, :use_route => :mappable
          response.should_not redirect_to(Map.last) # rails default
          response.should redirect_to('/mappable/')
        end
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        it "redirects to the maps list" do
          map = Mappable::Map.create!(subject: 'account', attr: 'name', from: 'legacy', to: 'current')
          put :update, id: map.id, :use_route => :mappable
          response.should_not redirect_to(map) # rails default
          response.should redirect_to('/mappable/')
        end
      end
    end
  end
end
