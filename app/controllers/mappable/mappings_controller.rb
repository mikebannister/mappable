module Mappable
  class MappingsController < ApplicationController
    def index
      @mappings = Mapping.all
    end
  
    def show
      @mapping = Mapping.find(params[:id])
    end
  
    def new
      @mapping = Mapping.new
    end
  
    def edit
      @mapping = Mapping.find(params[:id])
    end
  
    def create
      @mapping = Mapping.new(params[:mapping])
  
      if @mapping.save
        redirect_to @mapping, notice: 'Mapping was successfully created.'
      else
        render action: "new"
      end
    end
  
    def update
      @mapping = Mapping.find(params[:id])
  
      if @mapping.update_attributes(params[:mapping])
        redirect_to @mapping, notice: 'Mapping was successfully updated.'
      else
        render action: "edit"
      end
    end
  
    def destroy
      @mapping = Mapping.find(params[:id])
      @mapping.destroy
  
      redirect_to mappings_url
    end
  end
end
