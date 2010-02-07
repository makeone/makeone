class CreateChemicalProperties < ActiveRecord::Migration
  def self.up
    create_table :chemical_properties do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :chemical_properties
  end
end
