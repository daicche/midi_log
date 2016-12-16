require "rubygems"
require "active_record"
require "yaml"
require "./app/models/note"

config = YAML.load_file( './config/database.yml' )
ActiveRecord::Base.establish_connection(config["db"])

Note.create
p Note.all
