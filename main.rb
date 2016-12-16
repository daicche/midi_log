require 'pry'
require 'json'
require 'unimidi'
require 'time'
require "rubygems"
require "active_record"
require "yaml"
require "./app/models/note"

config = YAML.load_file( './config/database.yml' )
ActiveRecord::Base.establish_connection(config["db"])

input = UniMIDI::Input.gets

puts "send some MIDI to your input now..."

def have_midi_signal?(midi_data)
  midi_data.length == 3
end

def on_key_up?(midi_data)
  midi_data[2] == 0
end

def sustain_pedal?(midi_data)
  midi_data[0] == 176
end

while true
  m = input.gets
  midi_data = m[0][:data]
  if have_midi_signal?(midi_data) # && !on_key_up?(midi_data) && !sustain_pedal?(midi_data)
    output = "#{m[0][:data]}\t#{m[0][:timestamp]}\t#{Time.new.to_s}"
    puts(output)
    `echo #{output} >> ./log/#{Time.now.strftime('%Y_%m_%d')}.tsv`

    Note.create(event: midi_data[0], pitch: midi_data[1], velocity: midi_data[2], detailed_timestamp: m[0][:timestamp])
  end
end
