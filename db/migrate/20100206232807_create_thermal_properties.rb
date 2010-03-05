class CreateThermalProperties < ActiveRecord::Migration
  def self.up
    create_table :thermal_properties do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :thermal_properties
  end
end
