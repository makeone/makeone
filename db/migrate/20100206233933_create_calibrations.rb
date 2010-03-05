class CreateCalibrations < ActiveRecord::Migration
  def self.up
    create_table :calibrations do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :calibrations
  end
end
