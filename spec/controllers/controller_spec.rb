require 'spec_helper'

module Mappable
  describe "Controller" do
    render_views

    before(:each) do
      Mappable::Map.create!(subject: 'account', attr: 'name', from: 'legacy', to: 'current')
      Mappable::Map.create!(subject: 'employee', attr: 'name', from: 'legacy', to: 'current')
    end

    context MappingsController do

      context "load_map_attributes" do
        it "assigns params[:subject] to @subject" do
          get :index, subject: 'account', attr: 'name', :use_route => :mappable
          assigns[:subject].should eq "account"
        end

        it "assigns the singular form params[:attr] to @attr" do
          get :index, subject: 'account', attr: 'names', :use_route => :mappable
          assigns[:attr].should eq "name"
        end

        it "assigns params[:subject] to @attr" do
          get :index, subject: 'account', attr: 'name', :use_route => :mappable
          assigns[:attr].should eq "name"
        end

      end

      it "renders the engine's template by default" do
        get :index, subject: 'account', attr: 'name', :use_route => :mappable
        response.body.should_not have_content "from main app's map name dir"
      end

      it "render's templates in view directory named after the map" do
        get :index, subject: 'employee', attr: 'name', :use_route => :mappable
        response.body.should have_content "mappings::from main app's map name dir"
      end
    end

    context MapsController do
      it "renders the engine's template by default" do
        get :index, subject: 'account', attr: 'name', :use_route => :mappable
        response.body.should_not have_content "from main app's map name dir"
      end

      it "render's templates in view directory named after the map" do
        get :index, subject: 'employee', attr: 'name', :use_route => :mappable
        response.body.should have_content "maps::from main app's map name dir"
      end
    end
  end
end
