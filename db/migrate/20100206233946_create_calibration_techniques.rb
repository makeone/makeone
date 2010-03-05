class CreateCalibrationTechniques < ActiveRecord::Migration
  def self.up
    create_table :calibration_techniques do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :calibration_techniques
  end
end
