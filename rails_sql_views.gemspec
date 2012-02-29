# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rails_sql_views}
  s.version = "0.8.2"

  s.required_rubygems_version = Gem::Requirement.new("> 1.3.1") if s.respond_to? :required_rubygems_version=
  s.authors = ["Anthony Eden"]
  s.date = %q{2011-05-13}
  s.description = %q{Adds support for using SQL views within ActiveRecord}
  s.email = %q{josh@technicalpickles.com}
  s.extra_rdoc_files = [
    "LICENSE",
    "README",
    "TODO"
  ]
  s.files = [
    "CHANGELOG",
    "README",
    "Rakefile",
    "lib/active_record/view.rb",
    "lib/core_ext/module.rb",
    "lib/rails_sql_views.rb",
    "lib/rails_sql_views/connection_adapters/abstract/schema_definitions.rb",
    "lib/rails_sql_views/connection_adapters/abstract/schema_statements.rb",
    "lib/rails_sql_views/connection_adapters/abstract_adapter.rb",
    "lib/rails_sql_views/connection_adapters/mysql_adapter.rb",
    "lib/rails_sql_views/connection_adapters/mysql2_adapter.rb",
    "lib/rails_sql_views/connection_adapters/oci_adapter.rb",
    "lib/rails_sql_views/connection_adapters/oracle_adapter.rb",
    "lib/rails_sql_views/connection_adapters/oracleenhanced_adapter.rb",
    "lib/rails_sql_views/connection_adapters/postgresql_adapter.rb",
    "lib/rails_sql_views/connection_adapters/sqlite3_adapter.rb",
    "lib/rails_sql_views/connection_adapters/sqlite_adapter.rb",
    "lib/rails_sql_views/connection_adapters/sqlserver_adapter.rb",
    "lib/rails_sql_views/loader.rb",
    "lib/rails_sql_views/schema_dumper.rb",
    "lib/rails_sql_views/version.rb"
  ]
  s.homepage = %q{http://activewarehouse.rubyforge.org/rails_sql_views}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.6.0}
  s.summary = %q{Library which adds SQL Views to ActiveRecord.}
  s.test_files = [
    "test/adapter_test.rb",
    "test/connection/native_mysql/connection.rb",
    "test/connection/native_postgresql/connection.rb",
    "test/connection/oracle_enhanced/connection.rb",
    "test/models/item.rb",
    "test/models/person.rb",
    "test/models/person2.rb",
    "test/models/place.rb",
    "test/models/v_person.rb",
    "test/models/v_profile.rb",
    "test/schema.native_mysql.expected.rb",
    "test/schema.native_postgresql.expected.rb",
    "test/schema.oracle_enhanced.expected.rb",
    "test/schema_dumper_test.rb",
    "test/test_helper.rb",
    "test/view_model_test.rb",
    "test/view_operations_test.rb"
  ]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activerecord>, [">= 0"])
    else
      s.add_dependency(%q<activerecord>, [">= 0"])
    end
  else
    s.add_dependency(%q<activerecord>, [">= 0"])
  end
end

