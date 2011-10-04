# Configure Rails Environment
ENV["RAILS_ENV"] = "test"
require File.expand_path("../dummy/config/environment.rb", __FILE__)
require 'rspec/rails'

Rails.backtrace_cleaner.remove_silencers!

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.mock_with :mocha

  config.before(:all) do
    DeferredGarbageCollection.start
  end

  config.after(:all) do
    DeferredGarbageCollection.reconsider
  end
end

def clear_kernel_method(sym)
  begin
    Kernel.send :remove_method, sym
    class << Kernel; self; end.send :remove_method, sym
  rescue
  end
end

def add_view(root, file, content)
  if root == :engine
    root_path = File.expand_path('../../..', __FILE__)
  elsif root == :main_app
    root_path = Rails.root
  end

  view_root = File.join(root_path, 'app/views')
  view_full_path = "#{File.join(view_root, file)}.html.erb"
  view_full_path_dir = File.expand_path('..', view_full_path)

  FileUtils.mkdir_p(view_full_path_dir)
  FileUtils.touch(view_full_path)
  File.open(view_full_path, 'w') {|f| f.write(content) }
end
