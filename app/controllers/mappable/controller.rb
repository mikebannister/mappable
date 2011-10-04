module Mappable
  class Controller < ::ApplicationController
    before_filter :load_map_attributes

    def render(*args, &block)
      options = _normalize_render(*args, &block)
      options[:prefixes].unshift map_specific_view_path
      self.response_body = render_to_body(options)
    end

    private

    def map_specific_view_path
      "#{@subject}_#{@attr}/#{engine_controller}"
    end

    def engine_controller
      params[:controller].split("/").last
    end

    def load_map_attributes
      @subject = params[:subject]
      @attr = params[:attr].try(:singularize)
    end
  end
end
