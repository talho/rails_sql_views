module RailsSqlViews
  module ConnectionAdapters
    module PostgreSQLAdapter
      def self.included(base)
        base.alias_method_chain :tables, :views
        base.alias_method_chain :table_exists?, :view
	base.send :alias_method :disable_referential_integrity_without_views, :disable_referential_integrity
      end
      # Returns true as this adapter supports views.
      def supports_views?
        true
      end

      def tables_with_views(name = nil)
        q = <<-SQL
        SELECT table_name, table_type
          FROM information_schema.tables
         WHERE table_schema IN (#{schemas})
           AND table_type IN ('BASE TABLE', 'VIEW')
        SQL

        query(q, name).map { |row| row[0] }
      end
      
      def table_exists_with_view?(name)
        name          = name.to_s
        schema, table = name.split('.', 2)

        unless table # A table was provided without a schema
          table  = schema
          schema = nil
        end

        if name =~ /^"/ # Handle quoted table names
          table  = name
          schema = nil
        end

        query(<<-SQL).first[0].to_i > 0
          SELECT COUNT(*)
            FROM information_schema.tables
           WHERE table_type IN ('BASE TABLE', 'VIEW')
             AND table_name = '#{table.gsub(/(^"|"$)/,'')}'
             AND table_schema = #{schema ? "'#{schema}'" : "ANY (current_schemas(false))"}
        SQL
      end

      def disable_referential_integrity_without_views #:nodoc:
        if supports_disable_referential_integrity?() then
          execute(tables_without_views.collect { |name| "ALTER TABLE #{quote_table_name(name)} DISABLE TRIGGER ALL" }.join(";"))
        end
        yield
      ensure
        if supports_disable_referential_integrity?() then
          execute(tables_without_views.collect { |name| "ALTER TABLE #{quote_table_name(name)} ENABLE TRIGGER ALL" }.join(";"))
        end
      end

      def base_tables(name = nil)
        q = <<-SQL
        SELECT table_name, table_type
          FROM information_schema.tables
         WHERE table_schema IN (#{schemas})
           AND table_type = 'BASE TABLE'
        SQL

        query(q, name).map { |row| row[0] }
      end
      alias nonview_tables base_tables

      def views(name = nil) #:nodoc:
        q = <<-SQL
        SELECT table_name, table_type
          FROM information_schema.tables
         WHERE table_schema IN (#{schemas})
           AND table_type = 'VIEW'
        SQL

        query(q, name).map { |row| row[0] }
      end

      def view_select_statement(view, name = nil)
        q = <<-SQL
        SELECT view_definition
          FROM information_schema.views
         WHERE table_catalog = (SELECT catalog_name FROM information_schema.information_schema_catalog_name)
           AND table_schema IN (#{schemas})
           AND table_name = '#{view}'
        SQL

        select_value(q, name) or raise "No view called #{view} found"
      end

      private

      def schemas
        schema_search_path.split(/,/).map { |p| quote(p) }.join(',')
      end
    end
  end
end
