module Mappable
  class ViewsGenerator < Rails::Generators::NamedBase
    source_root File.expand_path('../../../../../app/views/mappable', __FILE__)
    argument :name, :type => :string, :default => ''

    def copy_view_files

      map_files = %w[
        maps/_form
        maps/edit
        maps/index
        maps/new
        maps/show
      ]

      mapping_files = %w[
        mappings/_form
        mappings/edit
        mappings/index
        mappings/new
        mappings/show
      ]

      files = mapping_files
      files += map_files if name.blank?

      files.each do |file|
        from_path = "#{file}.html.erb"

        path_parts = ["mappable"]
        path_parts.push(name) unless name.blank? # include the name as namespace if not blank
        path_parts.push("#{file}.html.erb")

        to_path = File.join('app/views', *path_parts)
        copy_file from_path, to_path
      end
    end
  end
end
