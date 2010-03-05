class CreateIntendedUses < ActiveRecord::Migration
  def self.up
    create_table :intended_uses do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :intended_uses
  end
end
