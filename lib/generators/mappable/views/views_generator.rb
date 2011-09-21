module Mappable
  class ViewsGenerator < Rails::Generators::NamedBase
    source_root File.expand_path('../../../../../app/views/mappable', __FILE__)
    argument :name, :type => :string, :default => 'views'

    def copy_view_files
      empty_directory "app/views/mappable/maps"
      copy_file "maps/_form.html.erb", "app/views/mappable/maps/_form.html.erb"
      copy_file "maps/edit.html.erb", "app/views/mappable/maps/edit.html.erb"
      copy_file "maps/index.html.erb", "app/views/mappable/maps/index.html.erb"
      copy_file "maps/new.html.erb", "app/views/mappable/maps/new.html.erb"
      copy_file "maps/show.html.erb", "app/views/mappable/maps/show.html.erb"
      empty_directory "app/views/mappable/mappings"
      copy_file "mappings/edit.html.erb", "app/views/mappable/mappings/edit.html.erb"
      copy_file "mappings/index.html.erb", "app/views/mappable/mappings/index.html.erb"
      copy_file "mappings/new.html.erb", "app/views/mappable/mappings/new.html.erb"
      copy_file "mappings/show.html.erb", "app/views/mappable/mappings/show.html.erb"
    end
  end
end
