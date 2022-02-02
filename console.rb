require "yaml"
require "active_record"

dbconfig = YAML.load(File.read("config/database.yml"))
ActiveRecord::Base.establish_connection dbconfig["db"]
require "groupdate"
require "./app/models/note.rb"
require 'highline'
h = HighLine.new

DISPLAING_DAY_RANGE = 44
DISPLAING_BAR_CHARACTER_SIZE = 30

counts = Note.group_by_day(:created_at).keystrokes.count

counts = counts.to_a[(
  [counts.length, DISPLAING_DAY_RANGE].max - DISPLAING_DAY_RANGE
)..counts.length]
max = counts.transpose[1].max

counts.each_with_index do |a, i|
  bar_length = a[1] * DISPLAING_BAR_CHARACTER_SIZE / max.to_f
  print a[0].strftime("%Y/%m/%d") + (
    (i == counts.length - 1) ?
    h.color(a[1].to_s.rjust(6), :black, :on_red)
    : a[1].to_s.rjust(6)
  ) + ' ' +
  (
    (i == counts.length - 1) ?
    h.color("█", :red) : '█'
  ) * bar_length + "\n"
end
