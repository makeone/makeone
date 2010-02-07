class CreateScanners < ActiveRecord::Migration
  def self.up
    create_table :scanners do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :scanners
  end
end
