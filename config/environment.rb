require 'bundler'
require 'active_record'
Bundler.require
require 'require_all'
require 'pry'

Dir[File.join(File.dirname(__FILE__), "../app/models", "*.rb")].each {|f| require f}

DB = ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_all 'lib'
require_all 'app'

ActiveRecord::Base.logger = nil
