module Itsf
  module Services
    module Generators
      class InstallGenerator < Rails::Generators::Base
        desc 'Generates the initializer'

        source_root File.expand_path('../templates', __FILE__)

        def generate_initializer
          copy_file 'initializer.rb', 'config/initializers/itsf_services.rb'
        end
      end
    end
  end
end
