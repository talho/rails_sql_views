require 'active_record'
require 'rails_sql_views'

module RailsSqlViews
  class Railtie < Rails::Railtie
    config.after_initialize do
      ActiveSupport.on_load(:active_record) do
        ActiveRecord::ConnectionAdapters::AbstractAdapter.class_eval do
          include RailsSqlViews::ConnectionAdapters::SchemaStatements
          def self.inherited(sub)
            RailsSqlViews::Loader.load_extensions
          end
        end

        ActiveRecord::SchemaDumper.class_eval do
          include RailsSqlViews::SchemaDumper
        end

        RailsSqlViews::Loader.load_extensions
      end
    end
  end
end
