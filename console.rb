require 'yaml'
require 'active_record'
require 'pry'
require 'pry-byebug'

dbconfig = YAML.load(File.read('config/database.yml'))
ActiveRecord::Base.establish_connection dbconfig['db']
require 'groupdate'
require './app/models/note.rb'

p Note.group_by_day(:created_at).keystrokes.count

binding.pry

Note.group_by_day(:created_at).keystrokes.count
