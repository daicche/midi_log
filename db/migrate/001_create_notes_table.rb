class CreateNotesTable < ActiveRecord::Migration
  def self.up
    create_table :notes do |t|
      t.integer :pitch
      t.integer :velocity
      t.integer :event # i.e. 0x90
      t.float :detailed_timestamp

      t.timestamps
    end

    add_index :notes, :pitch
    add_index :notes, :velocity
    add_index :notes, :event
    add_index :notes, :detailed_timestamp
  end
end
