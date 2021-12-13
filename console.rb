require "yaml"
require "active_record"

dbconfig = YAML.load(File.read("config/database.yml"))
ActiveRecord::Base.establish_connection dbconfig["db"]
require "groupdate"
require "./app/models/note.rb"

p Note.group_by_day(:created_at).keystrokes.count
