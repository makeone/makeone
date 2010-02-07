class CreateScannerTechnologies < ActiveRecord::Migration
  def self.up
    create_table :scanner_technologies do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :scanner_technologies
  end
end
