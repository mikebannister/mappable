require 'spec_helper'

module Mappable
  describe MappingsController do
    describe "POST create" do
      describe "with valid params" do
        it "redirects to the mappings list" do
          post :create, :use_route => :mappable
          response.should_not redirect_to(Mapping.last) # rails default
          response.should redirect_to('/mappable/mappings')
        end
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        it "redirects to the mappings list" do
          mapping = Mappable::Mapping.create!(from: 'moof', to: 'doof')
          put :update, id: mapping.id, :use_route => :mappable
          response.should_not redirect_to(mapping) # rails default
          response.should redirect_to('/mappable/mappings')
        end
      end
    end
  end
end
