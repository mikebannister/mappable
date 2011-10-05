module Mappable
  class MappingsController < ::ApplicationController
    before_filter :load_map_attributes
    before_filter :load_map, only: [:index, :new]

    def index
      @mappings = @map.mappings
    end

    def show
      @mapping = Mapping.find(params[:id])
    end

    def new
      @mapping = Mapping.new(map: @map)
    end

    def edit
      @mapping = Mapping.find(params[:id])
    end

    def create
      @mapping = Mapping.new(params[:mapping])

      if @mapping.save
        redirect_to mappings_path(subject: @mapping.parent_map.subject, attr: @mapping.parent_map.attr.pluralize), notice: 'Mapping was successfully created.'
      else
        render action: "new"
      end
    end

    def update
      @mapping = Mapping.find(params[:id])

      if @mapping.update_attributes(params[:mapping])
        redirect_to mappings_path(subject: @mapping.parent_map.subject, attr: @mapping.parent_map.attr.pluralize), notice: 'Mapping was successfully updated.'
      else
        render action: "edit"
      end
    end

    def destroy
      @mapping = Mapping.find(params[:id])
      @mapping.destroy

      redirect_to mappings_path
    end

    private

      def load_map
        @map = Map.find_by_subject_and_attr!(params[:subject], params[:attr].singularize)
      end

      def load_map_attributes
        @subject = params[:subject]
        @attr = params[:attr].singularize
      end

      def render(*args, &block)
        options = _normalize_render(*args, &block)
        options[:prefixes].unshift map_specific_view_path
        self.response_body = render_to_body(options)
      end

      def map_specific_view_path
        "mappable/#{@subject}_#{@attr.pluralize}/#{engine_controller}"
      end

      def engine_controller
        params[:controller].split("/").last
      end

  end
end
