class CreateMechanicalProperties < ActiveRecord::Migration
  def self.up
    create_table :mechanical_properties do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :mechanical_properties
  end
end
