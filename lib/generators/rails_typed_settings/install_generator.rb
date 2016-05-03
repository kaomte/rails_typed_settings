require 'rails/generators'
require 'rails/generators/migration'

module RailsTypedSettings
  class InstallGenerator < Rails::Generators::Base
    desc "Generate RailsTypedSettings files."
    include Rails::Generators::Migration

    source_root File.expand_path('../templates', __FILE__)

    def self.next_migration_number(dirname)
      if ActiveRecord::Base.timestamped_migrations
        Time.now.utc.strftime("%Y%m%d%H%M%S")
      else
        "%.3d" % (current_migration_number(dirname) + 1)
      end
    end
    
    def install_rails_typed_settings
      template 'model.rb', 'app/models/settings.rb'
      migration_template 'migration.rb', 'db/migrate/create_settings.rb'
    end
  end
end
