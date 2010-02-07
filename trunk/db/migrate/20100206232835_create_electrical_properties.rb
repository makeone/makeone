class CreateElectricalProperties < ActiveRecord::Migration
  def self.up
    create_table :electrical_properties do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :electrical_properties
  end
end
